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
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var tradeButton: UIButton!
    
    private var presenter: PokerViewPresenter!
    
    private var cards: [Card] {
        return cardViews.cards()
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PokerViewPresenter(updateCards: updateCards,
                                       handText: handText)
        cardViews.forEach { $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PokerViewController.selectCard))) }
        setSelectable(false)
    }
    
    private var updateCards: Binder<[Card]> {
        return Binder(self) { _self, cards in
            cards.enumerated().forEach {
                let cardView = _self.cardViews[$0.offset]
                cardView.card = $0.element
                cardView.isSelected = false // 選択状態を解除
            }
        }
    }
    
    private var handText: Binder<String?> {
        return Binder(self) { _self, text in
            _self.handLabel.text = text
        }
    }
    
    @objc private func selectCard(_ sender: UITapGestureRecognizer) {
        cardViews.filter { $0.tag == sender.view?.tag }.forEach { $0.isSelected = !$0.isSelected }
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        tradeButton.isEnabled = true
        sender.isEnabled = false
        setSelectable(true)
        presenter.postStart(gatherCards: cards)
    }
    
    @IBAction private func tapTradeButton(_ sender: UIButton) {
        startButton.isEnabled = true
        sender.isEnabled = false
        setSelectable(false)
        presenter.postTrade(selected: cardViews.selectedCards(), notSelected: cardViews.notSelectedCards())
    }
    
    func setSelectable(_ selectable: Bool) {
        cardViews.forEach { $0.isUserInteractionEnabled = selectable }
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
