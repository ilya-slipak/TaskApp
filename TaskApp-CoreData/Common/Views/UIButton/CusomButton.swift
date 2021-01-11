//
//  CusomButton.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class CustomButton: UIButton {
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
        
    private func setup() {
        
        tintColor = .white
        backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        layer.cornerRadius = 25
        titleLabel?.font = UIFont.boldSystemFont(ofSize: 15)
        contentEdgeInsets = UIEdgeInsets(top: 19, left: 30, bottom: 19, right: 30)
    }
}
