//
//  NekoRoomViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/16.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model
import Design
import RxSwift
import Utility

final class NekoRoomViewController: UIViewController, ColorSetViewProtocol {
    
    @IBOutlet private weak var nekoImage: NekoAnimateView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nekoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NekoRoomViewController.tapNeko)))
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Neko.selectedNeko().map(nekoImage.set)
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
    }
    
    @objc private func tapNeko(_ sender: UITapGestureRecognizer) {
        nekoImage.action(.meow)
    }
}
