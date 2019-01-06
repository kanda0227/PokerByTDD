//
//  CustomButton.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/25.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model

@IBDesignable public class CustomButton: UIButton {
    
    public var colorSet: ColorSet = .default {
        didSet {
            setColorSet()
        }
    }
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    func configure() {
        setColorSet()
    }
    
    func setColorSet() {}
}
