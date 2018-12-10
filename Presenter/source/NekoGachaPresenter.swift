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
    
    public init(walletText: Binder<String>,
                switchGachaButtonEnabled: Binder<Bool>,
                nekoBinder:Binder<(neko: Neko, new: Bool)?>) {
        self.nekoBinder = nekoBinder
        setupEvent(walletText: walletText, switchGachaButtonEnabled: switchGachaButtonEnabled)
        
        self.nekoBinder.onNext(nil)
    }
    
    private func setupEvent(walletText: Binder<String>, switchGachaButtonEnabled: Binder<Bool>) {
        // 所持金のテキスト更新
        Wallet.shared.observable().startWith(Wallet.shared.value()).map { "\($0)" }.subscribe(walletText).disposed(by: bag)
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
