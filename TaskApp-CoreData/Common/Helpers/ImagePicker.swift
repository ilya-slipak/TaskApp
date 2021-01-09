//
//  ImagePicker.swift
//  TaskApp-CoreData
//
//  Created by Ilya Slipak on 08.01.2021.
//

import UIKit
import Photos
import AVFoundation

final class ImagePicker: NSObject {
    
    // MARK: - Typealias
    
    typealias PickerResult = ((_ result: Result) -> Void)
    
    // MARK: - Public Properties
    
    var completion: PickerResult?
    
    // MARK: - Private Properties
    
    private var pickerType: PickerType
    private var compressionQuality: CGFloat
    
    init(pickerType: PickerType, compressionQuality: CGFloat) {
        
        self.pickerType = pickerType
        self.compressionQuality = compressionQuality
        super.init()
    }
    
    func presentImagePicker(in viewController: UIViewController,
                            sourceType: UIImagePickerController.SourceType,
                            completion: @escaping PickerResult) {
        
        self.completion = completion
        let imagePicker = UIImagePickerController()
        imagePicker.delegate = self
        imagePicker.mediaTypes = pickerType.mediaTypes
        imagePicker.sourceType = sourceType
        
        switch sourceType {
        case .camera:
            
            let status = AVCaptureDevice.authorizationStatus(for: AVMediaType.video)
            
            guard status != .restricted && status != .denied  else {
//                throw ErrorType.denied(errorMessage: NSLocalizedString("DISABLED_CAMERA_ACCESS_MESSAGE", comment: ""))
                print("DISABLED_CAMERA_ACCESS_MESSAGE")
                return
            }
            
            imagePicker.showsCameraControls = true
            imagePicker.cameraCaptureMode = .photo
            imagePicker.cameraDevice = .rear
            
            viewController.present(imagePicker, animated: true, completion: nil)
            
        case .photoLibrary, .savedPhotosAlbum:
            
            switch PHPhotoLibrary.authorizationStatus() {
            case .authorized, .limited:
                viewController.present(imagePicker, animated: true, completion: nil)
            case .notDetermined:
                PHPhotoLibrary.requestAuthorization { status in
                    guard status != .restricted && status != .denied  else {
                        return
                    }
                    DispatchQueue.main.async {
                        viewController.present(imagePicker, animated: true, completion: nil)
                    }
                }
            case .denied, .restricted:
//                throw ErrorType.denied(errorMessage: NSLocalizedString("DISABLED_CAMERA_ACCESS_MESSAGE", comment: ""))
            print("DISABLED_CAMERA_ACCESS_MESSAGE")
            @unknown default:
                fatalError("Please check new authorization status and setup proper flow for him")
            }
        @unknown default:
            break
        }
    }
    
    // MARK: - Private Methods
    
    private func generateImageURLPath(imageData: Data?) -> URL? {
        
        let filePath = "\(UUID().uuidString).jpeg"
        let fileUrl = FileManager.default.saveFile(with: filePath, data: imageData)
        
        return fileUrl
    }
}

 // MARK: - UIImagePickerControllerDelegate

extension ImagePicker: UIImagePickerControllerDelegate {
    
    func imagePickerController(_ picker: UIImagePickerController,
                               didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        
        if let originalImage = info[UIImagePickerController.InfoKey.originalImage] as? UIImage {
            let imageData = originalImage.jpegData(compressionQuality: 1)
            let compressedData = originalImage.jpegData(compressionQuality: 0.1)
            let originalURLPath = generateImageURLPath(imageData: imageData)
            let compressedURLPath = generateImageURLPath(imageData: compressedData)
            
            completion?(.success(originalURL: originalURLPath,
                                 compressedURL: compressedURLPath))
        }
        completion = nil
        picker.dismiss(animated: true, completion: nil)
    }
}

// MARK: - UINavigationControllerDelegate

extension ImagePicker: UINavigationControllerDelegate {
    
}

// MARK: - PickerType

extension ImagePicker {
    
    enum PickerType {
        
        case image
        case video
        
        var mediaTypes: [String] {
            
            switch self {
            case .image:
                return ["public.image"]
            case .video:
                return ["public.movie"]
            }
        }
    }
}

extension ImagePicker {
    
    enum Result {
        case success(originalURL: URL?, compressedURL: URL?)
    }
}
