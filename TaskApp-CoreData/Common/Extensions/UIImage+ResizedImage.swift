//
//  UIImage+ResizedImage.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

extension UIImage {
    
    func resizeImage(newSize: CGSize, quality: JPEGQuality) -> UIImage? {
        var actualHeight: CGFloat = size.height
        var actualWidth: CGFloat = size.width
        let maxHeight: CGFloat = newSize.height
        let maxWidth: CGFloat = newSize.width
        var imgRatio: CGFloat = actualWidth / actualHeight
        let maxRatio: CGFloat = maxWidth / maxHeight
        let compressionQuality = quality.rawValue

        if actualHeight > maxHeight || actualWidth > maxWidth {
            if imgRatio < maxRatio {
                //adjust width according to maxHeight
                imgRatio = maxHeight / actualHeight
                actualWidth = imgRatio * actualWidth
                actualHeight = maxHeight
            }
            else if imgRatio > maxRatio {
                //adjust height according to maxWidth
                imgRatio = maxWidth / actualWidth
                actualHeight = imgRatio * actualHeight
                actualWidth = maxWidth
            }
            else {
                actualHeight = maxHeight
                actualWidth = maxWidth
            }
        }

        let rect = CGRect(x: 0.0, y: 0.0, width: actualWidth, height: actualHeight)
        UIGraphicsBeginImageContext(rect.size)
        draw(in: rect)
        let image = UIGraphicsGetImageFromCurrentImageContext()
        let imageData = image?.jpegData(compressionQuality: compressionQuality)
        UIGraphicsEndImageContext()
        guard let unwrappedImageData = imageData else {
            return nil
        }
        
        return UIImage(data: unwrappedImageData)
    }
}

// MARK: - JPEGQuality

extension UIImage {
    
    enum JPEGQuality: CGFloat {
        case lowest  = 0
        case low     = 0.25
        case medium  = 0.5
        case high    = 0.75
        case highest = 1
    }
}
