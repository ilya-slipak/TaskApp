//
//  Theme.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

struct Theme {
    
    func setup() {
        
        setupNavigatioтTheme()
    }
    
    private func setupNavigatioтTheme() {
        
        UINavigationBar.appearance().isTranslucent = false
        UINavigationBar.appearance().barTintColor = #colorLiteral(red: 0.3411764706, green: 0.3333333333, blue: 0.7843137255, alpha: 1)
        UINavigationBar.appearance().tintColor = .white
        UINavigationBar.appearance().barStyle = .black
        UINavigationBar.appearance().titleTextAttributes = [
            .foregroundColor: UIColor.white,
            .font: UIFont.boldSystemFont(ofSize: 18)
        ]
    }
}
