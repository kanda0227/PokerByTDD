//
//  NekoGachaPresenter.swift
//  Presenter
//
//  Created by Kanda Sena on 2018/12/11.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Model

public final class NekoGachaPresenter {
    
    private let bag = DisposeBag()
    
    private let nekoBinder: Binder<(neko: Neko, new: Bool)?>
    
    public init(wallet: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)>,
                switchGachaButtonEnabled: Binder<Bool>,
                nekoBinder:Binder<(neko: Neko, new: Bool)?>) {
        self.nekoBinder = nekoBinder
        setupEvent(wallet: wallet, switchGachaButtonEnabled: switchGachaButtonEnabled)
        
        self.nekoBinder.onNext(nil)
    }
    
    private func setupEvent(wallet: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)>, switchGachaButtonEnabled: Binder<Bool>) {
        // 所持金のテキスト更新
        Wallet.shared.observable().subscribe(wallet).disposed(by: bag)
        // ガチャボタンの有効・無効切り替え
        NekoGacha.shared.canGachaObservable().subscribe(switchGachaButtonEnabled).disposed(by: bag)
    }
    
    public func gacha() {
        nekoBinder.onNext(NekoGacha.shared.get())
    }
    
    public func postViewWillAppear() {
        nekoBinder.onNext(nil)
    }
}
