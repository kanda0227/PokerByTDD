//
//  CardDesignChoiceViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Presenter
import RxSwift
import Model

final class CardDesignChoiceViewController: UIViewController, UINavigationControllerDelegate, ColorSetViewProtocol {
    
    private let imageSize = CGSize(width: 900, height: 1350)
    
    private let bag = DisposeBag()
    
    private lazy var presenter = CardDesignChoicePresenter()
    
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
    
    static func instantiate(category: CardDesignCategory) -> CardDesignChoiceViewController {
        let vc = UIViewController.instantiate(withStoryboardID: "CardDesignChoiceView") as! CardDesignChoiceViewController
        vc.title = category.rawValue
        vc.imageCategory = category
        vc.pickedImage = vc.presenter.restoreImage(category: category)
        return vc
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupColor()
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
    }
    
    @IBAction func tapSelectFromAlbumButton(_ sender: Any) {
        presentImagePickerVC(type: .photoLibrary)
    }
    
    @IBAction func tapTakePictureButton(_ sender: Any) {
        presentImagePickerVC(type: .camera)
    }
    
    @IBAction func tapDoneButton(_ sender: Any) {
        if let image = pickedImage {
            presenter.saveImage(image, category: imageCategory)
        }
        navigationController?.popViewController(animated: true)
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
            pickedImage = image.resize(imageSize)
        }
        picker.dismiss(animated: true, completion: nil)
    }
    
    public func imagePickerControllerDidCancel(_ picker: UIImagePickerController) {
        picker.dismiss(animated: true, completion: nil)
    }
}
