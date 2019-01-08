//
//  CommonTabBarController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/17.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model
import RxSwift
import Utility

final class TopTabBarController: UITabBarController, ColorSetViewProtocol {
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDisposable().disposed(by: bag)
        delegate = self
        AudioHelper.shared.musicPlay()
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
    }
    
    func reloadColor(colorSet: ColorSet) {
        tabBar.barTintColor = colorSet.tabBarColor()
        tabBar.tintColor = colorSet.tabBarItemColor()
    }
}

extension TopTabBarController: UITabBarControllerDelegate {
    
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        let selectable = TopTabSelectableNotification.shared.shouldSelectable()
        if !selectable {
            self.present(UIAlertController.alert(title: "ポーカーゲームが終わるまで\nタブの切り替えは出来ません"), animated: true, completion: nil)
        }
        return selectable
    }
}
