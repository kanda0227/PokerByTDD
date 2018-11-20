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
    }
    
    @IBAction private func tapTradeButton(_ sender: UIButton) {
        
    }
}

