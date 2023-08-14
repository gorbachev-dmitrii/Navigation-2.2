//
//  ImagePicker.swift
//  Navigation
//
//  Created by Dima Gorbachev on 12.08.2023.
//  Copyright © 2023 Artem Novichkov. All rights reserved.
//

import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate {
    static let defaultPicker = ImagePicker()
    
    let picker = UIImagePickerController()
    var completionBlock: ((_ imageData: Data?)-> ())!
    
    func showPicker(in viewController: UIViewController, completion: @escaping (_ imageData: Data?)-> ()) {
        completionBlock = completion
        picker.delegate = self
        picker.sourceType = .photoLibrary
        viewController.present(picker, animated: true)
    }
    
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        let data = (info[.originalImage] as? UIImage)?.pngData()
        completionBlock(data)
        picker.dismiss(animated: true)
    }
}
