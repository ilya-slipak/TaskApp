//
//  NewTaskViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class NewTaskViewController: UIViewController {
    
    // MARK: - IBOultet Properties

    @IBOutlet private weak var titleTextField: CustomTextField!
    @IBOutlet private weak var titleErrorLabel: ErrorLabel!
    @IBOutlet private weak var descriptionTextView: CustomTextView!
    @IBOutlet private weak var descriptionErrorLabel: ErrorLabel!
    @IBOutlet private weak var photoMediaPicker: MediaPickerView!
    @IBOutlet private weak var videoMediaPicker: MediaPickerView!
    @IBOutlet private weak var createButton: CustomButton!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()

       setupView()
    }
    
    // MARK: - Setup Methods
    
    private func setupView() {
        
        title = "New task"
        titleTextField.placeholder = "Enter task name"
        descriptionTextView.setupPlaceholder(text: "Description")
        photoMediaPicker.setup(with: [], type: .image)
        videoMediaPicker.setup(with: [], type: .video)
    }
    
    func validateData() -> Bool {
        
        var title = ""
        var description = ""
        do {
            title = try titleTextField.validatedText(validationType: .text)
            titleErrorLabel.hide()
        } catch let error as ValidationError {
            titleErrorLabel.show(withMessage: error.message)
        } catch {
            titleErrorLabel.show(withMessage: error.localizedDescription)
        }
        
        do {
            description = try descriptionTextView.validatedText(validationType: .text)
            descriptionErrorLabel.hide()
        } catch let error as ValidationError {
            descriptionErrorLabel.show(withMessage: error.message)
        } catch {
            descriptionErrorLabel.show(withMessage: error.localizedDescription)
        }
        
        return !title.isEmpty && !description.isEmpty
    }
    
    // MARK: - Action Methods
    
    @IBAction func createButtonAction(_ sender: CustomButton) {
        
        //TODO: createButtonAction
        guard validateData() else {
            return
        }
        navigationController?.popViewController(animated: true)
    }
}
