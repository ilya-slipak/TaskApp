//
//  BasePickerViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

class BasePickerViewController: UIViewController {
    
    // MARK: - Properties
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var bottomSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSafeAreaHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Closure Properties
    
    var onApply: (() -> Void)?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        show()
    }
    
    // MARK: - Private Methods
        
    private func setupView() {
        
        setupText()
        setupSafeAreaView()
        let contentHeight = contentView.frame.height + safeAreaView.frame.height
        bottomSafeAreaConstraint.constant = -contentHeight
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 20
    }
    
    private func setupText() {
        
        cancelButton.setTitle("Cancel", for: .normal)
        applyButton.setTitle("Apply", for: .normal)
    }
    
    private func setupSafeAreaView() {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        let bottomPadding = window.safeAreaInsets.bottom
        bottomSafeAreaHeightConstraint.constant = bottomPadding
    }
    
    private func closePicker() {
        
        hide { [weak self] in
            self?.dismiss(animated: false, completion: nil)
        }
    }
    
    private func show() {
        
        bottomSafeAreaConstraint.constant = 0
        updateAppearance(completion: nil)
    }
    
    private func hide(completion: @escaping () -> Void) {
        
        let contentHeight = contentView.frame.height + safeAreaView.frame.height
        bottomSafeAreaConstraint.constant = -contentHeight
        updateAppearance(completion: completion)
    }
        
    private func updateAppearance(completion: (() -> Void)?) {
        
        UIView.animate(withDuration: 0.25, animations: {
            self.view.layoutIfNeeded()
        }) { _ in
            completion?()
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction private func applyButtonAction(_ sender: UIButton) {
        
        onApply?()
        closePicker()
    }
    
    @IBAction private func cancelButtonAction(_ sender: UIButton) {
        
        closePicker()
    }
}
