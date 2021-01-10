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
    
    func configure(with imageModel: ImageModel) {
        
        let fileName = imageModel.thumbnailURL.lastPathComponent
        let image = ImageStorage.shared.getImage(fileName: fileName)
        imageView.image = image?.resized(targetSize: frame.size)
//        do {
//            let image = try UIGraphicsRenderer.renderImageAt(
//                path: imageModel.thumbnailURL.path,
//                size: frame.size)
//            imageView.image = image
//        } catch {
//            print(error)
//        }

    }
}
