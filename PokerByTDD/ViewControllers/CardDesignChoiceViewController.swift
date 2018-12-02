//
//  CardDesignChoiceViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

final class CardDesignChoiceViewController: UIViewController, UINavigationControllerDelegate {
    
    @IBOutlet private weak var pickedImageView: UIImageView! 
    
    static func instantiate(category: CardDesignCategory) -> CardDesignChoiceViewController {
        let vc = UIViewController.instantiate(withStoryboardID: "CardDesignChoiceView") as! CardDesignChoiceViewController
        vc.title = category.rawValue
        return vc
    }
    
    @IBAction func tapSelectFromAlbumButton(_ sender: Any) {
        presentImagePickerVC(type: .photoLibrary)
    }
    
    @IBAction func tapTakePictureButton(_ sender: Any) {
        presentImagePickerVC(type: .camera)
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
        
    }
    
    private func presentImagePickerVC(type: UIImagePickerController.SourceType) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = type
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
    }
}

extension CardDesignChoiceViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            pickedImage.image = image
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
