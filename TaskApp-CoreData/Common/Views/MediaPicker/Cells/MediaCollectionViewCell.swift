//
//  MediaCollectionViewCell.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class MediaCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "MediaCollectionViewCell"
    
    // MARK: - IBOutlet Properties

    @IBOutlet private weak var imageView: UIImageView!
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        layer.cornerRadius = 8
    }
        
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Setup Methods
    
    func configure(with mediaModel: MediaModel) {
        
        let fileName = mediaModel.thumbnailFilename
        let imageURL = ImageStorage.shared.getFileURL(fileName: fileName)
        let image = UIImage(contentsOfFile: imageURL.path)
        imageView.image = image?.resized(targetSize: frame.size)
    }
}
