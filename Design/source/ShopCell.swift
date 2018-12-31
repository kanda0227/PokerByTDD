//
//  ShopCell.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/31.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

public final class ShopCell: UICollectionViewCell {
    
    @IBOutlet private weak var imageView: UIImageView!
    @IBOutlet private weak var label: CustomLabel!
    
    public func set(itemName: String, image: UIImage) {
        label.text = itemName
        imageView.image = image
    }
}
