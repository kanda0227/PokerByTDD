//
//  SelectButton.swift
//  Design
//
//  Created by Kanda Sena on 2019/01/06.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import UIKit
import Model

@IBDesignable public final class SelectButton: CustomButton {
    
    override func setColorSet() {
        backgroundColor = colorSet.backgroundColor()
        layer.cornerRadius = 5
        layer.borderColor = colorSet.navigationBarColor().cgColor
        layer.borderWidth = 1
        layer.masksToBounds = true
        
        guard let text = titleLabel?.text else { return }
        let attributedText = NSAttributedString(string: text,
                                                attributes: [.font : UIFont.systemFont(ofSize: 15),
                                                             .foregroundColor : colorSet.textColor()])
        setAttributedTitle(attributedText, for: .normal)
        titleEdgeInsets = UIEdgeInsets(top: 0, left: 8.0, bottom: 0, right: 8.0)
    }
}
