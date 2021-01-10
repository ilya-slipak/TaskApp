//
//  FileStorable.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import Foundation

protocol FileStorable {
    
    func saveFile(data: Data?) -> URL?
    func deleteFile(_ path: String)
    func checkPath(_ path: String) -> Bool
    func removeDirectory()
}

extension FileStorable {
    
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
