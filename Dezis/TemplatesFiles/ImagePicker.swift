//
//  ImagePicker.swift
//  Dezis
//
//  Created by Tatina Dzhakypbekova on 27/9/24.
//

import Foundation
import UIKit

class ImagePicker: NSObject, UIImagePickerControllerDelegate, UINavigationControllerDelegate  {
    var imagePickerController: UIImagePickerController?
    
    var completion: ((UIImage) ->())?
    
    func showImagePicker (in viewController: UIViewController, completion: ((UIImage) ->())? ){
        self.completion = completion
        imagePickerController = UIImagePickerController()
        imagePickerController?.delegate = self
        viewController.present(imagePickerController!, animated: true)
        
    }
   
    func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]){
        if let image = info[.originalImage] as? UIImage {
            self.completion?(image)
            picker.dismiss(animated: true)
        }
    }


    func imagePickerControllerDidCancel(_ picker: UIImagePickerController){
        picker.dismiss(animated: true)
    }
    
    
}
