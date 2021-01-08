//
//  ErrorLabel.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class ErrorLabel: UILabel {

    private var errorTextColor: UIColor = UIColor.red
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        setup()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        
        setup()
    }
    
    private func setup() {
        backgroundColor = .clear
        font = UIFont.systemFont(ofSize: 10)
        textColor = errorTextColor
        numberOfLines = 0
    }
    
    // MARK: - Public Methods
    
    func show(withMessage message: String?) {
        
        text = message
        if !isHidden {
            alpha = 1
            return
        }
        
        textColor = .clear
        alpha = 0.01
        
        UIView.animate(withDuration: 0.2, animations: {
            self.isHidden = false
        }, completion: { _ in
            UIView.animate(withDuration: 0.2) {
                self.textColor = self.errorTextColor
                self.alpha = 1
            }
        })
    }
    
    func hide() {
        
        UIView.animate(withDuration: 0.3) {
            self.isHidden = true
        }
    }
}
