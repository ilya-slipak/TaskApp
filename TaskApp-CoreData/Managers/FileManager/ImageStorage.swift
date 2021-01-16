//
//  ImageFileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import UIKit

final class ImageStorage {
    
    static let shared = ImageStorage()
}

// MARK: - FileStorage

extension ImageStorage: FileStorage {
    
    var storageURL: URL? {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory: URL = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("Images")

        if !FileManager.default.fileExists(atPath: dataPath.path) {

            do {
                try FileManager.default.createDirectory(at: dataPath, withIntermediateDirectories: false, attributes: nil)
            } catch {
                debugPrint(error.localizedDescription)
                return nil
            }
        }

        return dataPath
    }
}
