//
//  CustomTextField.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class CustomTextField: UITextField {
    
    override var placeholder: String? {
        didSet {
            setupPlaceholder()
        }
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
        
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        
        textColor = .white
        backgroundColor = #colorLiteral(red: 0.1176470588, green: 0.1176470588, blue: 0.1176470588, alpha: 1)
        font = UIFont.systemFont(ofSize: 14)
        setupPlaceholder()
    }

    private func setupPlaceholder() {
        
        let color = UIColor.white
        let font = UIFont.systemFont(ofSize: 14)
        
        let attributes: [NSAttributedString.Key: Any] = [
            .font: font,
            .foregroundColor: color
        ]
        
        let attributetString = NSAttributedString(string: placeholder ?? "",
                                                  attributes: attributes)
        attributedPlaceholder = attributetString
    }
}
