//
//  CustomTextView.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class CustomTextView: UITextView {
    
    var placeholder: String = ""
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
        
    func setupPlaceholder(text: String) {
        
        placeholder = text
        textColor = UIColor.white
        self.text = text
    }
    
    private func setup() {
        
        textColor = .white
        font = UIFont.systemFont(ofSize: 14)
        backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        layer.cornerRadius = 8
    }
    
    private func updateView(isBecomeFisrtResponder: Bool) {
        
        if text == placeholder, isBecomeFisrtResponder {
            text = ""
        } else if text.trimmingCharacters(in: .whitespaces).isEmpty {
            text = placeholder
        }
    }
    
    override func becomeFirstResponder() -> Bool {
        
        updateView(isBecomeFisrtResponder: true)
        return super.becomeFirstResponder()
    }
    
    override func resignFirstResponder() -> Bool {
        
        updateView(isBecomeFisrtResponder: false)
        return super.resignFirstResponder()
    }
}
