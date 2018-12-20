//
//  ColorSetViewProtocol.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/17.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import RxSwift
import Model

public protocol ColorSetViewProtocol {
    func reloadColor(colorSet: ColorSet)
}

public extension ColorSetViewProtocol where Self: UIViewController {
    
    func eventDisposable() -> Disposable {
        return ColorSetNotification.shared.observable().subscribe(onNext: { [weak self] colorSet in
            self?.reloadColor(colorSet: colorSet)
        })
    }
    
    func setupColor() {
        reloadColor(colorSet: ColorSet.restore())
    }
    
    func commonSetupColor(colorSet: ColorSet) {
        view.backgroundColor = colorSet.backgroundColor()
    }
}

public extension ColorSetViewProtocol where Self: UILabel {
    
    func reloadColor(colorSet: ColorSet) {
        textColor = colorSet.textColor()
    }
}

public extension ColorSetViewProtocol where Self: UIView {
    
    func reloadColor(colorSet: ColorSet) {
        subviews
            .filter { $0 is ColorSetViewProtocol }
            .forEach { ($0 as! ColorSetViewProtocol).reloadColor(colorSet: colorSet) }
    }
}
