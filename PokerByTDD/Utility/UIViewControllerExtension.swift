//
//  UIViewControllerExtension.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

extension UIViewController {
    
    static func instantiate(withStoryboardID storyboardID: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardID, bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
}
