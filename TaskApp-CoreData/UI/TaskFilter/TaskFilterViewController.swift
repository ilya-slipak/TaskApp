//
//  TaskFilterViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class TaskFilterViewController: BasePickerViewController {
    
    // MARK: - Properties
    
    var dataSource: [String] = ["All", "Pending", "Active", "Completed"]
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupPickerView()
        setupCallbacks()
    }
    
    private func setupPickerView() {
        
        pickerView.dataSource = self
        pickerView.delegate = self
    }
    
    private func setupCallbacks() {
        
        onApply = { [weak self] in
            //TODO: Apply action
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
        
        let title = dataSource[row]
        
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
        
        //TODO: didSelectRow
//        viewModel.selectedPickerValue = viewModel.dataSource[row]
//        setLabelComponentColor(for: row, in: component)
    }
}
