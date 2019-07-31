//
//  PhotosViewController.swift
//  QuickPhotos
//
//  Created by TJ on 7/28/19.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class PhotosViewController: UIViewController, UICollectionViewDelegate {
    
    @IBOutlet var collectionView: UICollectionView!
    
    var store: PhotoStore!
    var photoDataSource =  PhotoDataSource()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        collectionView.dataSource = photoDataSource
        collectionView.delegate = self
        
        updateDataSource()

        store.fetchInterestingPhotos { (photosResult) in
            self.updateDataSource()
        }
    }
    
    private func updateDataSource() {
        store.fetchAllPhotos { (photosResult) in
            switch photosResult {
            case let .success(photos):
                self.photoDataSource.photos = photos
            case .failure:
                self.photoDataSource.photos.removeAll()
            }
            self.collectionView.reloadSections(IndexSet(integer: 0))
        }
    }
    
    
    // MARK: - Table View Methods
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        
        let photo = photoDataSource.photos[indexPath.row]
        
        // Download the image data
        store.fetchImage(for: photo) { (imageResult) in
            
            /* The image path for the photo might have changed between the time that the request started and finished, so find the most recent index path */
            guard let photoIndex = self.photoDataSource.photos.firstIndex(of: photo), case let .success(image) = imageResult else {
                return
            }
            let photoIndexPath = IndexPath(item: photoIndex, section: 0)
            
            // When the request finishes, only update the cell if it's still visible
            if let cell = self.collectionView.cellForItem(at: photoIndexPath) as? PhotoCollectionViewCell {
                DispatchQueue.main.async {
                    cell.update(with: image)
                }
            }
        }
    }
    

    
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        let identifier = "showPhoto"
        
        switch segue.identifier {
        case identifier:
            if let selectedIndexPath = collectionView.indexPathsForSelectedItems?.first {
                let photo = photoDataSource.photos[selectedIndexPath.row]
                let destinationVC = segue.destination as! PhotoInfoViewController
                destinationVC.photo = photo
                destinationVC.store = store
            }
        default:
            preconditionFailure("Unexpected segue identifier.")
        }
    }
    

}
