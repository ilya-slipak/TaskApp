//
//  MediaPickerView.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

final class MediaPickerView: UIView {
    
    // MARK: - Closure Properties
    
    var onAdd: (() -> Void)?
    var onSelectCell: ((_ mediaModel: MediaModel) -> Void)?
    
    // MARK: - IBOutlet Properties

    @IBOutlet private weak var headerLabel: UILabel!
    @IBOutlet private weak var collectionView: UICollectionView!
    
    // MARK: - Private Properties
    
    private var flow: Flow = .add
    private var dataSource: [MediaModel] = [] {
        didSet {
            isHidden = dataSource.isEmpty && flow != .add
        }
    }
    
    // MARK: - Lifecycle Methods
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        makeFromNib()
        layer.cornerRadius = 8
        let mediaCellNib = UINib(nibName: "MediaCollectionViewCell", bundle: nil)
        let mediaCellReuseIdentifier = MediaCollectionViewCell.reuseIdentifier
        collectionView.register(mediaCellNib, forCellWithReuseIdentifier: mediaCellReuseIdentifier)
        
        let addMediaCellNib = UINib(nibName: "AddMediaCollectionViewCell", bundle: nil)
        let addMediaCellReuseIdentifier = AddMediaCollectionViewCell.reuseIdentifier
        collectionView.register(addMediaCellNib, forCellWithReuseIdentifier: addMediaCellReuseIdentifier)
    }
    
    // MARK: - Setup Methods
    
    func setup(with inputDataSource: [MediaModel], type: MediaType, inputFlow: Flow) {
        
        headerLabel.text = type.title
        flow = inputFlow
        updateDataSource(inputDataSource)
    }
    
    func updateDataSource(_ inputDataSource: [MediaModel]) {
        
        dataSource = inputDataSource
        collectionView.reloadData()
    }
}

// MARK: - UICollectionViewDataSource, UICollectionViewDelegate

extension MediaPickerView: UICollectionViewDataSource, UICollectionViewDelegate {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        if flow == .add {
            return dataSource.count + 1
        } else {
            return dataSource.count
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        guard indexPath.row != dataSource.count else {
            
            let identifier = AddMediaCollectionViewCell.reuseIdentifier
            let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! AddMediaCollectionViewCell
            
            return cell
        }
        
        let identifier = MediaCollectionViewCell.reuseIdentifier
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: identifier, for: indexPath) as! MediaCollectionViewCell
        let mediaData = dataSource[indexPath.row]
        cell.configure(with: mediaData)

        return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        
        guard indexPath.row != dataSource.count else {
            
            onAdd?()
            return
        }
        
        let data = dataSource[indexPath.row]
        onSelectCell?(data)
    }
}

// MARK: - UICollectionViewDelegateFlowLayout

extension MediaPickerView: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        
        return CGSize(width: 60, height: 60)
    }
}

// MARK: - MeidaType

extension MediaPickerView {
    
    enum MediaType {
        
        case image
        case video
        
        var title: String {
            switch self {
            case .image:
                return "Photos"
            case .video:
                return "Videos"
            }
        }
    }
}

// MARK: - Flow

extension MediaPickerView {
    
    enum Flow {
        case add
        case preview
        case edit
    }
}
