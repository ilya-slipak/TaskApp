//
//  FileStorable.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import Foundation

protocol FileStorage {
    
    // MARK: - Properties
    var documentDirectory: URL? { get }
    
    // MARK: - Methods
    func saveFile(data: Data?) -> URL?
    func deleteFile(_ path: String)
    func removeAll()
}

extension FileStorage {
    
    func getFileURL(fileName: String) -> URL {
        
        guard let documentDirectory = documentDirectory else {
            return URL(fileURLWithPath: "")
        }
        let fileURL = documentDirectory.appendingPathComponent(fileName)
        
        return fileURL
    }
    
    func deleteFile(_ path: String) {
        
        let isExist = checkPath(path)
        if isExist {
            do {
                try FileManager.default.removeItem(atPath: path)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    func checkPath(_ path: String) -> Bool {
        
        let isFileExist = FileManager.default.fileExists(atPath: path)
        return isFileExist
    }
}
