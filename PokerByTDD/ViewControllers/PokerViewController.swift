//
//  PokerViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import RxSwift
import RxCocoa

final class PokerViewController: UIViewController {
    
    @IBOutlet private var cardViews: [CardView]!
    @IBOutlet private weak var handLabel: UILabel!
    @IBOutlet private var opponentCardsViews: [CardView]!
    @IBOutlet private weak var opponentHandLabel: UILabel!
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var tradeButton: UIButton!
    
    private var presenter: PokerViewPresenter!
    
    private var cards: [Card] {
        return cardViews.cards()
    }
    
    private var opponentCards: [Card] {
        return opponentCardsViews.cards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PokerViewPresenter(updateCards: updateCards,
                                       handText: handText)
        cardViews.forEach { $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PokerViewController.selectCard))) }
        setSelectable(false)
    }
    
    private var updateCards: Binder<(cards: [Card], opponentCards: [Card])> {
        return Binder(self) { _self, params in
            let (cards, opponentCards) = params
            cards.enumerated().forEach { index, card in
                let cardView = _self.cardViews.filter { $0.tag == index }.first
                cardView?.card = card
                cardView?.isSelected = false // 選択状態を解除
            }
            opponentCards.enumerated().forEach { index, card in
                let cardView = _self.opponentCardsViews.filter { $0.tag == index }.first
                cardView?.card = card
            }
        }
    }
    
    private var handText: Binder<(hand: String?, opponentHand: String?, result: String?)> {
        return Binder(self) { _self, params in
            let (hand, opponentHand, result) = params
            _self.handLabel.text = hand
            _self.opponentHandLabel.text = opponentHand
            _self.resultLabel.text = result
        }
    }
    
    @objc private func selectCard(_ sender: UITapGestureRecognizer) {
        cardViews.filter { $0.tag == sender.view?.tag }.forEach { $0.isSelected = !$0.isSelected }
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        tradeButton.isEnabled = true
        sender.isEnabled = false
        setSelectable(true)
        turnOverCards(isBack: false)
        turnOverOpponentCards(isBack: true)
        let bet = 0
        presenter.postStart(gatherCards: cards, opponentCards: opponentCards, bet: bet)
    }
    
    @IBAction private func tapTradeButton(_ sender: UIButton) {
        startButton.isEnabled = true
        sender.isEnabled = false
        setSelectable(false)
        turnOverOpponentCards(isBack: false)
        presenter.postTrade(selected: cardViews.selectedCards(), notSelected: cardViews.notSelectedCards())
    }
    
    func setSelectable(_ selectable: Bool) {
        cardViews.forEach { $0.isUserInteractionEnabled = selectable }
    }
    
    func turnOverCards(isBack: Bool) {
        cardViews.forEach { $0.isBack = isBack }
    }
    
    func turnOverOpponentCards(isBack: Bool) {
        opponentCardsViews.forEach { $0.isBack = isBack }
    }
}

private extension Array where Element==CardView {
    
    func selectedCards() -> [Card] {
        return filter { $0.isSelected }.cards()
    }
    
    func notSelectedCards() -> [Card] {
        return filter { !$0.isSelected }.cards()
    }
    
    func cards() -> [Card] {
        return map { $0.card }.filter { $0 != nil }.map { $0! }
    }
}
