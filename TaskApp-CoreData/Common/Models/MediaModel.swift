//
//  MediaModel.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 13.01.2021.
//

import Foundation

protocol MediaModel {
    
    var originalFilename: String { get }
    var thumbnailFilename: String { get }
}
