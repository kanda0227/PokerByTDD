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
import RxCocoa
import Presenter
import Design

final class NekoGachaViewController: UIViewController {
    
    @IBOutlet private weak var nekoImageView: UIImageView!
    @IBOutlet private weak var nekoLabel: UILabel!
    @IBOutlet private weak var walletView: WalletView!
    @IBOutlet private weak var gachaButton: UIButton!
    @IBOutlet private weak var newImage: UIImageView!
    
    private lazy var presenter = NekoGachaPresenter(wallet: walletBinder,
                                                    switchGachaButtonEnabled: switchGachaButtonEnabled,
                                                    nekoBinder: nekoBinder)
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        presenter.postViewWillAppear()
    }
    
    private var walletBinder: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)> {
        return Binder(walletView) { walletView, elems in
            walletView.money = elems.money
            walletView.set(second: elems.count, presentMoneyPerTime: elems.perTime, shouldPresentMoney: elems.shouldPresentMoney)
        }
    }
    
    private var switchGachaButtonEnabled: Binder<Bool> {
        return Binder(self) { _self, isEnabled in
            _self.gachaButton?.isEnabled = isEnabled
        }
    }
    
    private var nekoBinder: Binder<(neko: Neko, new: Bool)?> {
        return Binder(self) { _self, elems in
            _self.nekoImageView?.image = elems?.neko.image
            _self.nekoLabel?.text = elems?.neko.name
            _self.newImage?.isHidden = !(elems?.new ?? false)
        }
    }
    
    @IBAction private func tapGachaButton(sender: Any) {
        presenter.gacha()
    }
}
