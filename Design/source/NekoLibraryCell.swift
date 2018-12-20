//
//  NekoLibraryCell.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/09.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model

public final class NekoLibraryCell: UICollectionViewCell {
    
    @IBOutlet private weak var nekoImageView: UIImageView!
    @IBOutlet private weak var nekoLabel: CustomLabel!
    
    public func set(neko: Neko, colorSet: ColorSet) {
        nekoImageView.image = neko.image()
        nekoLabel.text = neko.name
        setBorderColoer(colorSet: colorSet)
    }
    
    private func setBorderColoer(colorSet: ColorSet) {
        
        self.layer.borderColor = colorSet.navigationBarColor().cgColor
        self.layer.borderWidth = 2
        self.layer.cornerRadius = 5
    }
}
