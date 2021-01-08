//
//  AddMediaCollectionViewCell.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class AddMediaCollectionViewCell: UICollectionViewCell {
    
    static let reuseIdentifier = "AddMediaCollectionViewCell"

    @IBOutlet private weak var addLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        addLabel.layer.borderWidth = 1
        addLabel.layer.borderColor = UIColor.white.cgColor
        addLabel.layer.cornerRadius = 8
    }
}
