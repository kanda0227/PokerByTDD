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
    
    private var presenter: PokerViewPresenter!
    
    private var cards: [Card] {
        return cardViews.map { $0.card }.filter { $0 != nil }.map { $0! }
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
                _self.cardViews[$0.offset].card = $0.element
            }
        }
    }
    
    private var handText: Binder<String> {
        return Binder(self) { _self, text in
            _self.handLabel.text = text
        }
    }
    
    @objc private func selectCard(_ sender: UITapGestureRecognizer) {
        cardViews.filter { $0.tag == sender.view?.tag }.forEach { $0.isSelected = !$0.isSelected }
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        presenter.postStart(gatherCards: cards)
    }
    
    @IBAction private func tapTradeButton(_ sender: UIButton) {
        
    }
}
