//
//  UIImage+ResizedImage.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit

extension UIImage {
    
    func resized(targetSize: CGSize) -> UIImage? {
        
        let selfSize = size
        let widthRatio  = targetSize.width  / selfSize.width
        let heightRatio = targetSize.height / selfSize.height
        
        var newSize: CGSize
        if widthRatio > heightRatio {
            newSize = CGSize(width: selfSize.width * heightRatio, height: selfSize.height * heightRatio)
        } else {
            newSize = CGSize(width: selfSize.width * widthRatio,  height: selfSize.height * widthRatio)
        }
        
        let rect = CGRect(x: 0, y: 0, width: newSize.width, height: newSize.height)
        
        UIGraphicsBeginImageContextWithOptions(newSize, false, 0)
        draw(in: rect)
        let newImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        
        return newImage
    }
    
    func scale(by scale: CGFloat) -> UIImage? {

        let scaledSize = CGSize(width: size.width * scale, height: size.height * scale)
        return resized(targetSize: scaledSize)
    }
}
