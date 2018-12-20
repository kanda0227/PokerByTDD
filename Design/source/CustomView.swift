//
//  CustomView.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/20.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Model

public class CustomView: UIView, ColorSetViewProtocol {
    
    public func reloadColor(colorSet: ColorSet) {
        subviews
            .filter { $0 is ColorSetViewProtocol }
            .forEach { ($0 as! ColorSetViewProtocol).reloadColor(colorSet: colorSet) }
    }
}
