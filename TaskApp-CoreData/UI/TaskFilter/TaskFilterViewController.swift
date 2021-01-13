//
//  TaskFilterViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class TaskFilterViewController: BasePickerViewController {
    
    // MARK: - Private Properties
    
    private var dataSource = TaskFilterDataSource.allCases
    private var selectedFilterRule: TaskFilterDataSource = .all
    
    // MARK: - Closure Properties
    
    var onSelectFilterRule:((_ sortRule: TaskFilterDataSource) -> Void)?
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPickerView()
        setupCallbacks()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        performDefaultSelection()
    }
    
    // MARK: - Public Methods
    
    func setup(selectedFilterRule: TaskFilterDataSource) {
        
        self.selectedFilterRule = selectedFilterRule
    }
    
    // MARK: - Private Methods
    
    private func setupPickerView() {
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func performDefaultSelection() {
        
        guard let selectedIndex = dataSource.firstIndex(of: selectedFilterRule) else {
            return
        }
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
    
    private func setupCallbacks() {
        
        onApply = { [weak self] in
            guard let self = self else {
                return
            }
            self.onSelectFilterRule?(self.selectedFilterRule)
        }
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension TaskFilterViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
            label.textColor = UIColor.white
            label.text = title

            return label
        }
        
        pickerLabel.text = title
        
        return pickerLabel
    }
        
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        
        let newFilterRule = dataSource[row]
        selectedFilterRule = newFilterRule
    }
}
