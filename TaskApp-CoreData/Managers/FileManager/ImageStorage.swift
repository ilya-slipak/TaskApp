//
//  ImageFileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import Foundation

final class ImageStorage {
    
    static let shared = ImageStorage()
    
    // MARK: - Private Properties
    
    private func getDirectory() -> URL? {
        
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
}

// MARK: - FileStorable

extension ImageStorage: FileStorable {
    
    func saveFile(data: Data?) -> URL? {
        
        let fileName = "\(UUID().uuidString.lowercased()).jpeg"
        
        guard
            let directory = getDirectory(),
            let fileData = data else {
            return nil
        }
        
        let dataPath = directory.appendingPathComponent(fileName)
        
        if !FileManager.default.fileExists(atPath: dataPath.path) {
            do {
                try fileData.write(to: dataPath)
            } catch {
                print(error.localizedDescription)
                return nil
            }
        }
        
        return dataPath
    }
    
    func removeDirectory() {
        
        guard let directory = getDirectory() else {
            return
        }
        
        deleteFile(directory.absoluteString)
    }
}
