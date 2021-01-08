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
        
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageView.image = nil
    }
    
    // MARK: - Setup Methods
    
    func configure(data: Data) {
        
        imageView.image = UIImage(data: data)
    }
}
