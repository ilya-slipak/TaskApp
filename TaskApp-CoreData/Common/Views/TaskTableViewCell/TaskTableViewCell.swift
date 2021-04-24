//
//  TaskTableViewCell.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 10.01.2021.
//

import UIKit

final class TaskTableViewCell: UITableViewCell {
    
    static let reuseIdentifier = "TaskTableViewCell"
    
    // MARK: - IBOutlet Properties
    
    @IBOutlet private weak var containerView: UIView!
    @IBOutlet private weak var taskImageView: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        taskImageView.layer.cornerRadius = 8
        containerView.layer.cornerRadius = 8
    }
    
    // MARK: - Setup Methods
    
    func configure(with task: Task) {
        
        titleLabel.text = task.title
        descriptionLabel.text = task.info
        
        let imageFilename = task.photoAttachments?
            .allObjects
            .map { $0 as! File }
            .first?
            .filename
        
        guard
            let imageName = imageFilename,
            let imageURL = try? FileManager.imageStorage.getURL(by: imageName) else {
            setupEmptyImage()
            return
        }
        
        let image = UIImage(contentsOfFile: imageURL.path)
        taskImageView.image = image?.resized(targetSize: taskImageView.frame.size)
    }
    
    // MARK: - Private Methods
    
    private func setupEmptyImage() {
        
        let emptyImage = UIImage(named: "no-image")
        taskImageView.image = emptyImage?.resized(targetSize: taskImageView.frame.size)
    }
}
