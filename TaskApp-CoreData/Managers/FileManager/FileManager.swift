//
//  FileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 09.01.2021.
//

import Foundation

extension FileManager {
    
//    func canStoreOnDiskMore(_ moreSize: NSNumber) -> Bool {
//
//        var systemFreeSize = NSNumber(integerLiteral: 0)
//
//        if let size = ((try? FileManager.default.attributesOfFileSystem(forPath: NSHomeDirectory())[FileAttributeKey.systemFreeSize] as? NSNumber) as NSNumber??) {
//
//            systemFreeSize = size!
//        }
//
//        return systemFreeSize.compare(moreSize) == .orderedDescending
//    }
//
//    func addSkipBackupAttributeToItemAtURL(_ URL: Foundation.URL) -> Bool {
//
//        let filePath = URL.path
//        guard FileManager.default.fileExists(atPath: filePath) else {
//            return false
//        }
//
//        do {
//            try (URL as NSURL).setResourceValue(NSNumber(value: true as Bool), forKey: URLResourceKey.isExcludedFromBackupKey)
//            return true
//        } catch let error {
//            print("Error excluding \(URL.lastPathComponent) from backup \(error)")
//            return false
//        }
//    }
    
    func removeAll()  {
        
        if let directory = temporaryDirectory() {
            deleteFile(with: directory)
        }
        
        if let directory = documentDirectory() {
            deleteFile(with: directory)
        }
    }
    
    func saveFile(with fileName: String, data: Data?) -> URL? {
        
        guard let directory = documentDirectory(), let fileData = data else {
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
    
    //TODO: WIP
    func copyToDocumentDirectory(_ URL: URL) {
        
//        let isExist = checkPath(path)
//        guard !isExist else {
//            return
//        }
        
    }
    
    func checkPath(_ path: String) -> Bool {
        
        let isFileExist = FileManager.default.fileExists(atPath: path)
        return isFileExist
    }
    
    func deleteFile(with filename: URL?) {
        
        if let url = filename, FileManager.default.fileExists(atPath: url.path) {
            do {
                try FileManager.default.removeItem(at: url)
            } catch let error {
                print(error.localizedDescription)
            }
        }
    }
    
    private func documentDirectory() -> URL? {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory: URL = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent("DocumentStorage")
        
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
    
    private func temporaryDirectory() -> URL? {
        
        let paths = FileManager.default.temporaryDirectory
        let dataPath = paths.appendingPathComponent("TemporaryStorage")
        
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
