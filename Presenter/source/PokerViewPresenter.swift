//
//  PokerViewPresenter.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/22.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import RxSwift
import RxCocoa
import Model

// MARK: - PokerViewPresenter
/// ポーカー画面の Presenter
public final class PokerViewPresenter {
    
    /// カードの配布や交換をしてくれるディーラーさん
    private let dealer = Dealer()
    /// 今回は手札が5枚ずつのポーカーを想定
    private let useCardNum = 5
    
    private let bag = DisposeBag()
    
    private var bet = 0
    
    /// ユーザーの手札
    private var userCards: [(card: Card, isSelected: Bool)] = []
    /// 対戦相手の手札
    private var opponentCards: [Card] = []
    
    /// ユーザーと対戦相手のカードのビューを更新します
    private let updateCards: Binder<(cards: [Card], opponentCards: [Card])>
    /// ユーザーと対戦相手の役のテキストを表示します
    private let handText: Binder<(hand: String?, opponentHand: String?, result: String?)>
    /// 所持金の表示を更新します
    private let wallet: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)>
    /// ユーザーのカードをめくります
    private let turnOverUserCards: Binder<Bool>
    /// 対戦相手のカードをめくります
    private let turnOverOpponentCards: Binder<Bool>
    /// カードの選択可否を切り替えます
    private let switchSelectableCards: Binder<Bool>
    /// スタートボタンの有効・無効を切り替えます
    private let switchIsStartButtonEnabled: Binder<Bool>
    /// トレードボタンの有効・無効を切り替えます
    private let switchIsTradeButtonEnabled: Binder<Bool>
    /// 対戦相手の表情を切り替えます
    private let opponentFace: Binder<NekoFace>
    
    public init(updateCards: Binder<(cards: [Card], opponentCards: [Card])>,
         handText: Binder<(hand: String?, opponentHand: String?, result: String?)>,
         wallet: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)>,
         turnOverUserCards: Binder<Bool>,
         turnOverOpponentCards: Binder<Bool>,
         switchSelectableCards: Binder<Bool>,
         switchIsStartButtonEnabled: Binder<Bool>,
         switchIsTradeButtonEnabled: Binder<Bool>,
         opponentFace: Binder<NekoFace>) {
        self.updateCards = updateCards
        self.handText = handText
        self.wallet = wallet
        self.turnOverUserCards = turnOverUserCards
        self.turnOverOpponentCards = turnOverOpponentCards
        self.switchSelectableCards = switchSelectableCards
        self.switchIsStartButtonEnabled = switchIsStartButtonEnabled
        self.switchIsTradeButtonEnabled = switchIsTradeButtonEnabled
        self.opponentFace = opponentFace
        
        setupEvent()
    }
    
    private func setupEvent() {
        // 所持金の表示
        Wallet.shared.observable().subscribe(wallet.asObserver()).disposed(by: bag)
    }
}

// MARK: - VC 側で使用するためのメソッド等
extension PokerViewPresenter {
    
    /// 所持金を返します
    public func walletContent() -> Int {
        return Wallet.shared.value()
    }
    
    /// スタートボタンのタップ時に呼んでください
    public func postTapStartButton() {
        turnOverUserCards.onNext(true)
        turnOverOpponentCards.onNext(true)
    }
    
    /// ゲームスタート時に呼んでください
    public func postStart(bet: Int?) {
        guard let bet = bet else { return }
        self.bet = bet
        Wallet.shared.pay(bet)
        dealer.gatherCards(userCards.map { $0.card } + opponentCards)
        userCards = dealer.dealCards(useCardNum).sorted().map { ($0, false) }
        opponentCards = dealer.dealCards(useCardNum).sorted()
        updateCards.onNext((cards: userCards.map { $0.card },
                            opponentCards: opponentCards))
        handText.onNext((hand: nil, opponentHand: nil, result: nil))
        
        turnOverUserCards.onNext(false)
        switchSelectableCards.onNext(true)
        switchIsStartButtonEnabled.onNext(false)
        switchIsTradeButtonEnabled.onNext(true)
        TopTabSelectableNotification.shared.post(selectable: false)
        
        opponentFace.onNext(opponentFace(opponentCards))
    }
    
    /// カードの選択状態が変わるときに呼んでください
    public func switchIsSelectCard(tag: Int, isSelected: Bool) {
        userCards[tag].isSelected = isSelected
    }
    
    /// カード交換ボタンのタップ時に呼んでください
    public func postTrade() {
        let selected = userCards.filter { $0.isSelected }.map { $0.card }
        let notSelected = userCards.filter { !$0.isSelected }.map { $0.card }
        userCards = (dealer.tradeCards(selected) + notSelected).sorted().map { ($0, false) }
        let cards = userCards.map { $0.card }
        Result.setHands(user: cards, opponent: opponentCards)
        Wallet.shared.receipt(Result.receive(bet: bet))
        updateCards.onNext((cards: userCards.map { $0.card }, opponentCards: opponentCards))
        handText.onNext(Result.resultText(bet: bet))
        opponentFace.onNext(Result.opponentFace())
        
        turnOverOpponentCards.onNext(false)
        switchSelectableCards.onNext(false)
        switchIsStartButtonEnabled.onNext(true)
        switchIsTradeButtonEnabled.onNext(false)
        TopTabSelectableNotification.shared.post(selectable: true)
    }
}

// MARK: - 表示する勝敗結果の計算ロジック
extension PokerViewPresenter {
    
    fileprivate enum Result: String {
        case win = "勝ち(`･ω･´)"
        case lose = "負け(´･ω･`)"
        case draw = "引き分け(･_･)"
        
        static private var hands: [Hand] = []
        
        static fileprivate func setHands(user: [Card], opponent: [Card]) {
            hands = [Hand(cards: user, name: "user"),
                     Hand(cards: opponent, name: "opponent")]
        }
        
        static private var userHand: Hand {
            guard let hand = hands.first else {
                fatalError("setHands を先に呼んでください")
            }
            return hand
        }
        
        static private var opponentHand: Hand {
            guard let hand = hands.last else {
                fatalError("setHands を先に呼んでください")
            }
            return hand
        }
        
        static fileprivate func resultText(bet: Int) -> (hand: String?, opponentHand: String?, result: String?) {
            return (handText(userHand),
                    handText(opponentHand),
                    hands.result(userHand).text(receive: bet))
        }
        
        static fileprivate func receive(bet: Int) -> Int {
            return hands.receive(bet, hand: userHand)
        }
        
        static fileprivate func opponentFace() -> NekoFace {
            switch hands.result(userHand) {
            case .win:
                return .tearful
            case .lose:
                return .smile
            case .draw:
                return .pokerFace
            }
        }
        
        fileprivate func text(receive: Int) -> String {
            return rawValue + " + \(receive)"
        }
        
        static private func handText(_ hand: Hand) -> String {
            return hand.hand().text
        }
    }
    
    fileprivate func opponentFace(_ opponentCards: [Card]) -> NekoFace {
        switch Hand(cards: opponentCards).hand() {
        case .highCard:
            return .tearful
        case .onePair, .twoPair:
            return .pokerFace
        default:
            return .smile
        }
    }
}

private extension PokerResult {
    
    func result() -> PokerViewPresenter.Result {
        switch self {
        case .win:
            return .win
        case .draw:
            return .draw
        case .lose:
            return .lose
        }
    }
}

private extension Array where Element==Hand {
    
    private func table() -> Table {
        let table = Table()
        self.forEach { table.bet(hand: $0) }
        return table
    }
    
    func result(_ hand: Element) -> PokerViewPresenter.Result {
        return table().result(hand: hand).result()
    }
    
    func receive(_ bet: Int, hand: Element) -> Int {
        return table().receive(bet: bet, hand: hand)
    }
}
