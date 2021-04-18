//
//  FileStorage.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 18.04.2021.
//

import Foundation

final class FileStorage {
    
    private let name: String
    
    init(name: String) {
        
        self.name = name
    }
    
    lazy var storageURL: URL? = {
        
        let paths = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)
        let documentsDirectory: URL = paths[0]
        let dataPath = documentsDirectory.appendingPathComponent(name)
        
        if !isExist(at: dataPath.path) {

            do {
                try FileManager.default.createDirectory(at: dataPath,
                                                        withIntermediateDirectories: false,
                                                        attributes: nil)
            } catch {
                debugPrint(error.localizedDescription)
                return nil
            }
        }

        return dataPath
    }()
}

// MARK: - FileStorable

extension FileStorage: FileStorable { }
