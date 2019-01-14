//
//  UIViewControllerExtension.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

extension UIViewController {
    
    public static func instantiate(withStoryboardID storyboardID: String) -> UIViewController? {
        let storyboard = UIStoryboard(name: storyboardID, bundle: nil)
        return storyboard.instantiateInitialViewController()
    }
    
    public func push(_ vc: UIViewController) {
        (self as? UINavigationController)?.pushViewController(vc, animated: true)
    }
    
    public func popToRoot() {
        (self as? UINavigationController)?.popToRootViewController(animated: true)
    }
}
