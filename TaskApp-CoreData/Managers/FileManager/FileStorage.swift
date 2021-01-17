//
//  FileStorable.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import Foundation

protocol FileStorage {
    
    // MARK: - Properties
    
    var storageURL: URL? { get }
}

extension FileStorage {
    
    func saveFile(data: Data, fileName: String) throws -> URL {
        
        guard let storageURL = storageURL else {
            throw FileStorageError.emptyStorage
        }
        
        let fileURL = storageURL.appendingPathComponent(fileName)
        let isExist = fileExists(atPath: fileURL.path)
        if !isExist {
            try data.write(to: fileURL)
        }
        
        return fileURL
    }
    
    func getFileURL(fileName: String) throws -> URL {
        
        guard let storageURL = storageURL else {
            throw FileStorageError.emptyStorage
        }
        
        let fileURL = storageURL.appendingPathComponent(fileName)
        let isExist = fileExists(atPath: fileURL.path)
        guard isExist else {
            throw FileStorageError.emptyFile
        }
        return fileURL
    }
    
    func deleteFile(_ path: String) {
        
        let isExist = fileExists(atPath: path)
        if isExist {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch {
                debugPrint(error.localizedDescription)
            }
        }
    }
    
    func fileExists(atPath path: String) -> Bool {
        
        return FileManager.default.fileExists(atPath: path)
    }
    
    func removeAll() {
        
        guard let storageURL = storageURL else {
            let error = FileStorageError.emptyStorage
            debugPrint("Error:", error.localizedDescription)
            return
        }
        
        deleteFile(storageURL.absoluteString)
    }
}
