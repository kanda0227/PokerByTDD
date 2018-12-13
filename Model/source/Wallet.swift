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
public final class Wallet {
    
    private let walletContentKey = "WalletContentKey"
    private let lastPresentTimeKey = "LastPresentTimeKey"
    /// 永続化されたお金が無かった場合にあげるお金
    private let firstMoney = 300
    /// 1分あたりにあげるお金
    public let presentMoneyPerTime = 10
    /// 自然回復上限
    private let recoveryMax = 300
    /// 回復時間間隔
    private let interval = 60
    
    private lazy var moneySubject = BehaviorSubject<Int>(value: money)
    
    private lazy var countSubject = BehaviorSubject<Int>(value: counter)
    
    private var timer: Timer?
    
    /// シングルトン
    public static let shared = Wallet()
    
    private init() {}
    
    private lazy var money: Int = restore() ?? firstMoney
    private lazy var counter: Int = interval
    
    /// お財布モデルの設定をします
    ///
    /// applicationDidBecomeActive で呼んでください
    public func setup() {
        if let date: Date = restore() {
            let diffTime = Int(Date().timeIntervalSince(date))
            let offTime = diffTime / interval
            for _ in 0..<offTime { presentMoney() }
            let lastPresentTime = diffTime % interval
            counter = lastPresentTime
        }
        setupPresent()
    }
    
    private func setupPresent() {
        // 1分あたりに一定値お財布の中身を回復させる
        timer = Timer.scheduledTimer(timeInterval: 1, target: self, selector: #selector(self.countTime), userInfo: nil, repeats: true)
    }
    
    @objc private func countTime() {
        countDown()
        if counter == 0 {
            presentMoney()
        }
    }
    
    private func countDown() {
        counter = counter == 0 ? interval : counter - 1
        countSubject.onNext(counter)
    }
    
    private func presentMoney() {
        if shouldPresentMoney() {
            receipt(presentMoneyPerTime)
        }
        save(Date())
    }
    
    /// お財布モデルの設定をリセットします
    ///
    /// applicationDidEnterBackground で呼んでください
    public func reset() {
        // タイマーを切る
        timer?.invalidate()
    }
    
    public func receipt(_ value: Int) {
        save(money + value)
    }
    
    public func pay(_ value: Int) {
        save(money - value)
    }
    
    public func value() -> Int {
        return money
    }
    
    public func moneyObservable() -> Observable<Int> {
        return moneySubject.asObservable()
    }
    
    public func countDownObservable() -> Observable<Int> {
        return moneySubject.asObservable()
    }
    
    public func observable() -> Observable<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)> {
        return Observable.combineLatest(moneySubject.asObservable(),
                                        countSubject.asObservable())
            .map { ($0.0, $0.1, self.presentMoneyPerTime, self.shouldPresentMoney()) }
    }
    
    public func shouldPresentMoney() -> Bool {
        return recoveryMax > money
    }
    
    private func save(_ value: Int) {
        // 所持金を永続化
        UserDefaults.standard.set(value, forKey: walletContentKey)
        money = value
        moneySubject.onNext(value)
    }
    
    private func restore() -> Int? {
        // 永続化した値を取得
        return UserDefaults.standard.object(forKey: walletContentKey) as? Int
    }
    
    private func save(_ date: Date) {
        UserDefaults.standard.set(date, forKey: lastPresentTimeKey)
    }
    
    private func restore() -> Date? {
        return UserDefaults.standard.object(forKey: lastPresentTimeKey) as? Date
    }
}
