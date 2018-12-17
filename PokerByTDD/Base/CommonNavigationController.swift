//
//  CommonNavigationController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/17.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model
import RxSwift

final class CommonNavigationController: UINavigationController, ColorSetViewProtocol {
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupColor()
    }
    
    func reloadColor(colorSet: ColorSet) {
        navigationBar.barTintColor = colorSet.navigationBarColor()
        navigationBar.tintColor = colorSet.backgroundColor()
        navigationBar.titleTextAttributes = [.foregroundColor : colorSet.backgroundColor()]
    }
}
