//
//  NekoGachaViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/08.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import UIKit
import Model
import RxSwift

final class NekoGachaViewController: UIViewController {
    
    @IBOutlet private weak var nekoImageView: UIImageView!
    @IBOutlet private weak var nekoLabel: UILabel!
    @IBOutlet private weak var walletLabel: UILabel! {
        didSet {
            walletLabel.text = "\(Wallet.shared.value())"
        }
    }
    @IBOutlet private weak var gachaButton: UIButton!
    @IBOutlet private weak var newImage: UIImageView!
    
    private let bag = DisposeBag()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nekoImageView.image = nil
        nekoLabel.text = nil
        Wallet.shared.observable().map { "\($0)" }.subscribe(walletLabel.rx.text).disposed(by: bag)
        NekoGacha.shared.canGachaObservable().subscribe(gachaButton.rx.isEnabled).disposed(by: bag)
    }
    
    @IBAction private func tapGachaButton(sender: Any) {
        let neko = NekoGacha.shared.get()
        nekoImageView.image = neko?.neko.image
        nekoLabel.text = neko?.neko.name
        newImage.isHidden = !(neko?.new ?? false)
    }
    }
}
