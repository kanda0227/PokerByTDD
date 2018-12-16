//
//  NekoGacha.swift
//  Model
//
//  Created by Kanda Sena on 2018/12/08.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift

public final class NekoGacha {
    
    private let wallet = Wallet.shared
    private let gachaPrice = 200
    private lazy var canGachaSubject = BehaviorSubject<Bool>(value: canGacha)
    private let bag = DisposeBag()
    
    private init() {
        wallet.observable()
            .subscribe(onNext: { [weak self] _ in
                guard let _self = self else { return }
                _self.canGachaSubject.onNext(_self.canGacha) })
            .disposed(by: bag)
    }
    
    public static let shared = NekoGacha()
    
    public func get() -> (neko: Neko, new: Bool)? {
        guard canGacha else { return nil }
        wallet.pay(gachaPrice)
        let neko = Neko.allNekos.randomElement()!
        let new = !neko.restore()
        neko.save()
        return (neko, new)
    }
    
    private var canGacha: Bool {
        return wallet.value() >= gachaPrice
    }
    
    public func canGachaObservable() -> Observable<Bool> {
        return canGachaSubject.asObservable()
    }
}
