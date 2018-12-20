//
//  CustomLabel.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/20.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model
import Utility

public class CustomLabel: UILabel, ColorSetViewProtocol {
    
    public func reloadColor(colorSet: ColorSet) {
        textColor = colorSet.textColor()
    }
}
