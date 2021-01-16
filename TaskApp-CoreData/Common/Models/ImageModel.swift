//
//  ImageModel.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 11.01.2021.
//

import Foundation

struct ImageModel {
    
    var originalURL: URL
}

// MARK: - MediaModel

extension ImageModel: MediaModel {
    
    var filename: String {
       return originalURL.lastPathComponent
    }
}
