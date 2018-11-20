//
//  PokerViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

class PokerViewController: UIViewController {
    
    private let dealer = Dealer()
    private let useCardNum = 5
    @IBOutlet private var cardViews: [CardView]!
    @IBOutlet private weak var handLabel: UILabel!
    
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        sender.isEnabled = false
        // 一旦カードを集める
        dealer.gatherCards(cardViews.map { $0.card }.filter { $0 != nil }.map { $0! })
        let cards = dealer.dealCards(useCardNum)
        cards.enumerated().forEach {
            cardViews[$0.offset].card = $0.element
        }
        handLabel.text = Hand(cards: cards).hand().text
        sender.isEnabled = true
    }
    
    @IBAction private func tapTradeButton(_ sender: UIButton) {
        
    }
}

