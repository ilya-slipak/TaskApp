//
//  NewTaskViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class NewTaskViewController: UIViewController {
    
    // MARK: - IBOutlet Properties

    @IBOutlet private weak var titleTextField: CustomTextField!
    @IBOutlet private weak var titleErrorLabel: ErrorLabel!
    @IBOutlet private weak var descriptionTextView: CustomTextView!
    @IBOutlet private weak var descriptionErrorLabel: ErrorLabel!
    @IBOutlet private weak var photoMediaPicker: MediaPickerView!
    @IBOutlet private weak var videoMediaPicker: MediaPickerView!
    @IBOutlet private weak var createButton: CustomButton!
    
    // MARK: - Private Properties
    
    private var taskDatabaseManager: TaskDatabaseManagerProtocol = TaskDatabaseManager()
    private let imagePicker = MediaPicker(pickerType: .image)
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
        photoMediaPicker.setup(with: images, type: .image, inputFlow: .add)
        videoMediaPicker.setup(with: [], type: .video, inputFlow: .add)
        videoMediaPicker.isHidden = true
        
        photoMediaPicker.onAdd = { [weak self] in
            
            guard let self = self else {
                return
            }
            
            self.imagePicker.presentImagePicker(in: self, sourceType: .photoLibrary) { [weak self] result in

                switch result {
                case .success(let image):
                    self?.saveImage(image)
                }
            }
        }
        
        photoMediaPicker.onSelectCell = { [weak self] mediaModel in
            let controller = ScreenFactory.makePhotoPreviewScreen(with: mediaModel)
            self?.present(controller, animated: true)
        }
    }
    
    private func saveImage(_ image: UIImage) {
        
        guard let imageData = image.jpegData(compressionQuality: 1) else {
            return
        }
        let fileName = "\(UUID().uuidString.lowercased()).jpeg"
        do {
            let originalURL = try FileManager.imageStorage.save(imageData, fileName: fileName)
            let imageModel = ImageModel(originalURL: originalURL)
            self.images.append(imageModel)
            self.photoMediaPicker.updateDataSource(self.images)
        } catch {
            debugPrint("Error", error.localizedDescription)
        }
    }
    
   private func validateData() -> Bool {
        
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
        
        guard validateData() else {
            return
        }
        
        taskDatabaseManager.create(title: titleTextField.text!,
                                       description: descriptionTextView.text,
                                       images: images)
        navigationController?.popViewController(animated: true)
    }
}
