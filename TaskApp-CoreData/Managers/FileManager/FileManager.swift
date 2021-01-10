//
//  FileManager.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 09.01.2021.
//

import Foundation

extension FileManager {
    
    func removeAll()  {
        
        ImageStorage.shared.removeDirectory()
        VideoStorage.shared.removeDirectory()
    }
}
