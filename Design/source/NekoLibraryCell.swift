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
    
    private let unknownNekoImage = #imageLiteral(resourceName: "neko")
    private let unknownNekoName = "？？？"
    
    @IBOutlet private weak var nekoImageView: UIImageView!
    @IBOutlet private weak var nekoLabel: UILabel!
    
    public func set(neko: Neko) {
        let hasNeko = neko.hasNeko
        nekoImageView.image = hasNeko ? neko.image : unknownNekoImage
        nekoLabel.text = hasNeko ? neko.name : unknownNekoName
        setBorderColoer()
    }
    
    private func setBorderColoer() {
        let colorName = "pink"
        let borderWidth: CGFloat = 2
        let cornerRadius: CGFloat = 5
        
        self.layer.borderColor = UIColor(named: colorName)?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
    }
}
