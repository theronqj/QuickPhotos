//
//  PhotoCollectionViewCell.swift
//  QuickPhotos
//
//  Created by TJ on 7/30/19.
//  Copyright © 2019 TJ. All rights reserved.
//

import UIKit

class PhotoCollectionViewCell: UICollectionViewCell
{
    @IBOutlet var imageView: UIImageView!
    @IBOutlet var spinner: UIActivityIndicatorView!
    
    // Helper method for spinner update
    func update(with image: UIImage?) {
        if let imageToDisplay = image {
            spinner.stopAnimating()
            imageView.image = image
        } else {
            spinner.startAnimating()
            imageView.image = nil
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        update(with: nil)
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        update(with: nil)
    }
}
