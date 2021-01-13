//
//  TaskSortViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class TaskSortViewController: BasePickerViewController {

    // MARK: - Properties
    
    private var dataSource = TaskSortDataSource.allCases
    private var selectedSortRule: TaskSortDataSource = .createdAtAscending
    
    // MARK: - Closure Properties
    
    var onSelectSortRule:((_ sortRule: TaskSortDataSource) -> Void)?
    
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
    
    func setup(selectedSortRule: TaskSortDataSource) {
        
        self.selectedSortRule = selectedSortRule
    }
    
    // MARK: - Private Methods
    
    private func setupPickerView() {
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func performDefaultSelection() {
        
        guard let selectedIndex = dataSource.firstIndex(of: selectedSortRule) else {
            return
        }
        pickerView.selectRow(selectedIndex, inComponent: 0, animated: true)
    }
    
    private func setupCallbacks() {
        
        onApply = { [weak self] in
            guard let self = self else {
                return
            }
            self.onSelectSortRule?(self.selectedSortRule)
        }
    }
}

// MARK: - UIPickerViewDataSource, UIPickerViewDelegate

extension TaskSortViewController: UIPickerViewDataSource, UIPickerViewDelegate {
    
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
        
        let newSortRule = dataSource[row]
        selectedSortRule = newSortRule
    }
}
