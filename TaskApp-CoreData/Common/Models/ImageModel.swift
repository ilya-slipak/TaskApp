//
//  ImageModel.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 11.01.2021.
//

import Foundation

struct ImageModel {
    
    var originalURL: URL
    var thumbnailURL: URL
}

// MARK: - MediaModel

extension ImageModel: MediaModel {
    
    var originalFilename: String {
       return originalURL.lastPathComponent
    }
    
    var thumbnailFilename: String {
        return thumbnailURL.lastPathComponent
    }
}
