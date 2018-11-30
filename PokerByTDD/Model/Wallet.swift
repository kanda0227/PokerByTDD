//
//  Wallet.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/30.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift

/// お財布モデル
final class Wallet {
    
    private let walletContentKey = "WalletContentKey"
    /// 永続化されたお金が無かった場合は 1000 円あげる
    private let firstMoney = 1000
    
    private lazy var subject = BehaviorSubject<Int>(value: money)
    
    /// シングルトン
    static let shared = Wallet()
    
    private init() {}
    
    private lazy var money: Int = restore() ?? firstMoney
    
    func receipt(_ value: Int) {
        save(money + value)
    }
    
    func pay(_ value: Int) {
        save(money - value)
    }
    
    func value() -> Int {
        return money
    }
    
    func observable() -> Observable<Int> {
        return subject.asObservable()
    }
    
    private func save(_ value: Int) {
        // 所持金を永続化
        UserDefaults.standard.set(value, forKey: walletContentKey)
        money = value
        subject.onNext(value)
    }
    
    private func restore() -> Int? {
        // 永続化した値を取得
        return UserDefaults.standard.object(forKey: walletContentKey) as? Int
    }
}
