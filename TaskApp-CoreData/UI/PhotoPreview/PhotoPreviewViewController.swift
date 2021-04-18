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
    @IBOutlet private weak var heightConstraint: NSLayoutConstraint!
    
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
        
        setupConstraint()
        setupImage()
    }
    
    private func setupConstraint() {
        
        guard let window = UIApplication.shared.keyWindow else {
            return
        }
        
        view.layoutIfNeeded()
        let topInset = window.safeAreaInsets.top
        heightConstraint.constant += topInset
    }
    
    private func setupImage() {
        
        let fileName = mediaModel.filename
        guard let imageURL = try? FileManager.imageStorage.getURL(for: fileName) else {
            imageView.image = nil
            return
        }
        
        let image = UIImage(contentsOfFile: imageURL.path)
        imageView.image = image
    }
    
    // MARK: - Action Methods
    
    @IBAction func closeButtonAction(_ sender: UIButton) {
        
        dismiss(animated: true)
    }
}
