//
//  ShopViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/30.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Model

final class ShopViewController: UIViewController, ColorSetViewProtocol {
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
    }
}
