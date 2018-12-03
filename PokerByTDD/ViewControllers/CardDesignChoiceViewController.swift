//
//  CardDesignChoiceViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import RealmSwift

final class CardDesignChoiceViewController: UIViewController, UINavigationControllerDelegate {
    
    private let imageSize = CGSize(width: 900, height: 1350)
    
    @IBOutlet private weak var pickedImageView: UIImageView! {
        didSet {
            pickedImageView.image = pickedImage
        }
    }
    private var imageCategory: CardDesignCategory!
    private var pickedImage: UIImage? {
        didSet {
            pickedImageView?.image = pickedImage
        }
    }
    private let realm = try! Realm()
    
    static func instantiate(category: CardDesignCategory) -> CardDesignChoiceViewController {
        let vc = UIViewController.instantiate(withStoryboardID: "CardDesignChoiceView") as! CardDesignChoiceViewController
        vc.title = category.rawValue
        vc.imageCategory = category
        vc.pickedImage = vc.realm.restoreImage(key: category.key())
        return vc
    }
    
    @IBAction func tapSelectFromAlbumButton(_ sender: Any) {
        presentImagePickerVC(type: .photoLibrary)
    }
    
    @IBAction func tapTakePictureButton(_ sender: Any) {
        presentImagePickerVC(type: .camera)
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
        if let image = pickedImage {
            saveImage(image)
        }
        navigationController?.popViewController(animated: true)
    }
    
    private func presentImagePickerVC(type: UIImagePickerController.SourceType) {
        let imagePickerVC = UIImagePickerController()
        imagePickerVC.sourceType = type
        imagePickerVC.delegate = self
        present(imagePickerVC, animated: true, completion: nil)
    }
    
    private func restoreImage() -> UIImage? {
        return realm.restoreImage(key: imageCategory.key())
    }
    
    private func saveImage(_ image: UIImage) {
        realm.saveImage(image, key: imageCategory.key())
    }
}

extension CardDesignChoiceViewController: UIImagePickerControllerDelegate {
    
    public func imagePickerController(_ picker: UIImagePickerController, didFinishPickingMediaWithInfo info: [UIImagePickerController.InfoKey : Any]) {
        if let image = info[.originalImage] as? UIImage {
            // 画像のリサイズ
            // TODO: この辺りのロジックは Presenter を作成して移動させたい
            let scale = min(imageSize.height/image.size.height,
                            imageSize.width/image.size.width)
            let resizedSize = CGSize(width: image.size.width * scale, height: image.size.height * scale)
            UIGraphicsBeginImageContext(resizedSize)
            image.draw(in: CGRect(x: 0, y: 0, width: resizedSize.width, height: resizedSize.height))
            let resizedImage = UIGraphicsGetImageFromCurrentImageContext()
            UIGraphicsEndImageContext()
            pickedImage = resizedImage
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
