//
//  TaskSortViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class PickerViewController: UIViewController {
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet weak var contentView: UIView!
    @IBOutlet weak var safeAreaView: UIView!
    @IBOutlet weak var applyButton: UIButton!
    @IBOutlet weak var cancelButton: UIButton!
    @IBOutlet weak var separatorView: UIView!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var bottomSafeAreaConstraint: NSLayoutConstraint!
    @IBOutlet weak var bottomSafeAreaHeightConstraint: NSLayoutConstraint!
    
    // MARK: - Private Properties
    
    private var dataSource: [PickerRuleModel] = []
    private var selectedIndex: Int = 0
    
    // MARK: - Closure Properties
    
    var onApply: ((_ index: Int) -> Void)?
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        show()
        performDefaultSelection()
    }
    
    // MARK: - Private Methods
        
    private func setupView() {
        
        setupText()
        setupSafeAreaView()
        let contentHeight = contentView.frame.height + safeAreaView.frame.height
        bottomSafeAreaConstraint.constant = -contentHeight
        contentView.layer.maskedCorners = [.layerMinXMinYCorner, .layerMaxXMinYCorner]
        contentView.layer.cornerRadius = 20
        setupPickerView()
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
        
        onApply?(selectedIndex)
        closePicker()
    }
    
    @IBAction private func cancelButtonAction(_ sender: UIButton) {
        
        closePicker()
    }
    
    // MARK: - Public Methods
    
    func setup(dataSource: [PickerRuleModel], selectedIndex: Int) {
        
        self.dataSource = dataSource
        self.selectedIndex = selectedIndex
    }
    
    // MARK: - Private Methods
    
    private func setupPickerView() {
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func performDefaultSelection() {
        
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension PickerViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        
        return dataSource.count
    }
    
    func pickerView(_ pickerView: UIPickerView, viewForRow row: Int, forComponent component: Int, reusing view: UIView?) -> UIView {
        
        let title = dataSource[row].title
        
        guard let pickerLabel = view as? UILabel else {
            
            let label = UILabel()
            label.font = UIFont.systemFont(ofSize: 15)
            label.textAlignment = .center
            label.textColor = .white
            label.text = title
            
            return label
        }
        
        pickerLabel.text = title
        
        return pickerLabel
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        selectedIndex = row
    }
}
