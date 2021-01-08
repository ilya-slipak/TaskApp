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
    
    // MARK: - Private Properties
    
    private let imagePicker = ImagePicker(pickerType: .image, compressionQuality: 0.1)
    private var images: [ImageModel] = []
    
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
        
        photoMediaPicker.onAdd = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.imagePicker.presentImagePicker(in: self, sourceType: .photoLibrary) { result in
                switch result {
                case .success(let data, let compressedData):
                    guard let data = data, let compressedData = compressedData else {
                        return
                    }
                    let newImageModel = ImageModel(originalData: data, compressedData: compressedData)
                    self.images.append(newImageModel)
                    self.photoMediaPicker.appendNewElement(data: compressedData)
                }
            }
            
        }
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
    
    private func prepareTaskModel(title: String, description: String){
        
        let context = DatabaseManager.shared.context
        var photoAttachements: [File] = []
        var videoAttachements: [File] = []
        
        images.forEach { image in
            
            let file = File(originalData: image.originalData,
                            compressedData: image.compressedData,
                            context: context)
            photoAttachements.append(file)
        }
        let _ = Task(title: title, description: description, photoAttachments: photoAttachements, videoAttachments: videoAttachements, context: context)
    }
    
    // MARK: - Action Methods
    
    @IBAction func createButtonAction(_ sender: CustomButton) {
        
        //TODO: createButtonAction
        guard validateData() else {
            return
        }
        
        prepareTaskModel(title: titleTextField.text!,
                                         description: descriptionTextView.text)
        DatabaseManager.shared.saveContext()
        navigationController?.popViewController(animated: true)
    }
}

 // MARK: - ImageModel

extension NewTaskViewController {
    
    struct ImageModel {
        
        var originalData: Data
        var compressedData: Data
    }
}
