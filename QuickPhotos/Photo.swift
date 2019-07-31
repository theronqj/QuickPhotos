//
//  Photo.swift
//  QuickPhotos
//
//  Created by TJ on 7/30/19.
//  Copyright © 2019 TJ. All rights reserved.
//

import Foundation

class Photo {
    
    let title: String
    let remoteURL: URL
    let photoID: String
    let dateTaken: Date
    
    init(title: String, remoteURL: URL, photoID: String, dateTaken: Date) {
        self.title = title
        self.remoteURL = remoteURL
        self.photoID = photoID
        self.dateTaken = dateTaken
    }

}

extension Photo: Equatable {
        
    static func == (lhs: Photo, rhs: Photo) -> Bool {
        // Two photos are the same if they have the same photoID
        return lhs.photoID == rhs.photoID
    }
}
