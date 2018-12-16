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

final class NekoRoomViewController: UIViewController {
    
    @IBOutlet private weak var nekoImage: NekoAnimateView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nekoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NekoRoomViewController.tapNeko)))
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Neko.selectedNeko().map(nekoImage.set)
    }
    
    @objc private func tapNeko(_ sender: UITapGestureRecognizer) {
        nekoImage.action()
    }
}
