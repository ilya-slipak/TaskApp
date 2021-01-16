//
//  PhotoPreviewViewController.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class PhotoPreviewViewController: UIViewController {
     
    // MARK: - IBOutlet Properties
    
    @IBOutlet private weak var closeButton: UIButton!
    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Private Properties
    
    private var mediaModel: MediaModel!
    
    // MARK: - Lifecycle Methods

    override func viewDidLoad() {
        super.viewDidLoad()

        setupView()
    }
    
    // MARK: - Setup Methods
    
    func setup(with mediaModel: MediaModel) {
        
        modalPresentationStyle = .overFullScreen
        self.mediaModel = mediaModel
    }
    
    // MARK: - Private Methods
    
    private func setupView() {
        
        let fileName = mediaModel.filename
        do {
            let imageURL = try ImageStorage.shared.getFileURL(fileName: fileName)
            let image = UIImage(contentsOfFile: imageURL.path)
            imageView.image = image
        } catch let error as FileStorageError {
            debugPrint("Error:", error.localizedDescription)
        } catch {
            debugPrint("Error:", error.localizedDescription)
        }
    }
    
    // MARK: - Action Methods
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}
