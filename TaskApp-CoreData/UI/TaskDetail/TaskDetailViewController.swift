//
//  TaskDetailViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 07.01.2021.
//

import UIKit

final class TaskDetailViewController: UIViewController {
    
    // MARK: - IBOutlet Properties

    @IBOutlet private weak var titleTextField: CustomTextField!
    @IBOutlet private weak var descriptionTextView: CustomTextView!
    @IBOutlet private weak var photoMediaPicker: MediaPickerView!
    @IBOutlet private weak var videoMediaPicker: MediaPickerView!
    @IBOutlet private weak var changeTaskStatusButton: CustomButton!
    
    // MARK: - Private Properties
    
    private var task: Task!
    
    // MARK: - Lifecycle Methods
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupView()
    }
    
    // MARK: - Setup Methods
    
    func setup(with task: Task) {
        
        self.task = task
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        setupText()
        setupMediaPickers()
        setupChangeTaskButton()
    }
    
    private func setupText() {
        
        title = "Task Detail"
        titleTextField.text = task.title
        descriptionTextView.text = task.info
    }
    
    private func setupMediaPickers() {
        
        let images = task.photoAttachments?
            .allObjects
            .map { $0 as! File } ?? []
        photoMediaPicker.setup(with: images, type: .image, inputFlow: .preview)
        videoMediaPicker.setup(with: [], type: .video, inputFlow: .preview)
        
        photoMediaPicker.onSelectCell = { [weak self] mediaModel in
            let controller = ScreenFactory.makePhotoPreviewScreen(with: mediaModel)
            self?.present(controller, animated: true)
        }
    }
    
    private func setupChangeTaskButton() {
        
        switch task.taskStatus {
        case .pending:
            changeTaskStatusButton.isHidden = false
            changeTaskStatusButton.setTitle("Accept", for: .normal)
        case .accepted:
            changeTaskStatusButton.isHidden = false
            changeTaskStatusButton.setTitle("Complete", for: .normal)
        case .completed:
            changeTaskStatusButton.isHidden = true
            changeTaskStatusButton.setTitle("", for: .normal)
        default:
            break
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func changeTaskStatusAction(_ sender: CustomButton) {
        
        switch task.taskStatus {
        case .pending:
            TaskDatabaseManager.shared.updateTaskStatus(task, newStatus: .accepted)
        case .accepted:
            TaskDatabaseManager.shared.updateTaskStatus(task, newStatus: .completed)
        default:
            break
        }
        navigationController?.popViewController(animated: true)
    }
}
