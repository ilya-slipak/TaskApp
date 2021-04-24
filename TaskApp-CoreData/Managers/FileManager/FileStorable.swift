//
//  FileStorable.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import Foundation

protocol FileStorable {
    
    // MARK: - Methods
    
    func removeAll()
    func delete(at path: String)
    func isExist(at path: String) -> Bool
    func getURL(by fileName: String) throws -> URL
    func save(_ data: Data, by fileName: String) throws -> URL
}

extension FileStorable where Self: FileStorage {
    
    func removeAll() {
        
        guard let storageURL = url else {
            let error = FileStorageError.emptyStorage
            debugPrint("Error:", error.localizedDescription)
            return
        }
        
        delete(at: storageURL.absoluteString)
    }
    
    func delete(at path: String) {
        
        guard isExist(at: path) else {
            return
        }
        
        do {
            try FileManager.default.removeItem(atPath: path)
        } catch {
            debugPrint("Failed to delete file:",error.localizedDescription)
        }
    }
    
    func isExist(at path: String) -> Bool {
        
        return FileManager.default.fileExists(atPath: path)
    }
    
    func getURL(by fileName: String) throws -> URL {
        
        guard let storageURL = url else {
            throw FileStorageError.emptyStorage
        }
        
        let fileURL = storageURL.appendingPathComponent(fileName)

        return fileURL
    }
    
    func save(_ data: Data, by fileName: String) throws -> URL {
        
        guard let storageURL = url else {
            throw FileStorageError.emptyStorage
        }
        
        let fileURL = storageURL.appendingPathComponent(fileName)
        if !isExist(at: fileURL.path) {
            try data.write(to: fileURL)
        }
        
        return fileURL
    }
}
