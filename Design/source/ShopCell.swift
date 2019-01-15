//
//  ShopCell.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/31.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Model

public final class ShopCell: UICollectionViewCell, ColorSetViewProtocol {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: CustomLabel!
    
    public func set(itemName: String, image: UIImage) {
        label.text = itemName
        imageView.image = image
        setupColor()
    }
    
    public func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
        label.reloadColor(colorSet: colorSet)
    }
}
