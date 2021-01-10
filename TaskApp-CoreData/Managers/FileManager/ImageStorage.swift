//
//  ImageFileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import UIKit

final class ImageStorage {
    
    static let shared = ImageStorage()
    
    // MARK: - Properties
    
    var documentDirectory: URL? {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory: URL = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("Images")
        
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            
            do {
                try FileManager.default.createDirectory(at: dataPath, withIntermediateDirectories: false, attributes: nil)
            } catch let error as NSError {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return dataPath
    }
    
    // MARK: - Public Methods
    
    func getImage(fileName: String) -> UIImage? {
        
        guard let documentDirectory = documentDirectory else {
            return nil
        }
        let imageURL = documentDirectory.appendingPathComponent(fileName)
        let image = UIImage(contentsOfFile: imageURL.path)
        
        return image
    }
}

// MARK: - FileStorage

extension ImageStorage: FileStorage {
    
    func saveFile(data: Data?) -> URL? {
        
        let fileName = "\(UUID().uuidString.lowercased()).jpeg"
        
        guard
            let directory = documentDirectory,
            let fileData = data else {
            return nil
        }
        
        let fileURL = directory.appendingPathComponent(fileName)
        
        if !FileManager.default.fileExists(atPath: fileURL.path) {
            do {
                try fileData.write(to: fileURL)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return fileURL
    }
    
    func removeAll() {
        
        guard let directory = documentDirectory else {
            return
        }
        
        deleteFile(directory.absoluteString)
    }
}
