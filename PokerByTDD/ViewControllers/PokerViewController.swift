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

/// ポーカー画面
final class PokerViewController: UIViewController {
    
    /// ユーザーのカードのビュー
    @IBOutlet private var userCardViews: [CardView]!
    /// ユーザーの役を表示するラベル
    @IBOutlet private weak var userHandLabel: UILabel!
    /// 対戦相手のカードのビュー
    @IBOutlet private var opponentCardsViews: [CardView]!
    /// 対戦相手の役を表示するラベル
    @IBOutlet private weak var opponentHandLabel: UILabel!
    /// 対戦結果を表示するラベル
    @IBOutlet private weak var resultLabel: UILabel!
    @IBOutlet private weak var startButton: UIButton!
    @IBOutlet private weak var tradeButton: UIButton!
    /// 所持金を表示するラベル
    @IBOutlet private weak var walletLabel: UILabel!
    
    private var presenter: PokerViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PokerViewPresenter(updateCards: updateCards,
                                       handText: handText,
                                       walletText: walletText, turnOverUserCards: turnOverUserCards,
                                       turnOverOpponentCards: turnOverOpponentCards)
        userCardViews.forEach { $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PokerViewController.selectCard))) }
        setSelectable(false)
    }
    
    private var updateCards: Binder<(cards: [Card], opponentCards: [Card])> {
        return Binder(self) { _self, params in
            let (cards, opponentCards) = params
            cards.enumerated().forEach { index, card in
                let cardView = _self.userCardViews.filter { $0.tag == index }.first
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
            _self.userHandLabel.text = hand
            _self.opponentHandLabel.text = opponentHand
            _self.resultLabel.text = result
        }
    }
    
    private var walletText: Binder<String> {
        return Binder(walletLabel) { walletLabel, text in
            walletLabel.text = text
        }
    }
    
    private var turnOverUserCards: Binder<Bool> {
        return Binder(self) { _self, isBack in
            _self.userCardViews.forEach { $0.isBack = isBack }
        }
    }
    
    private var turnOverOpponentCards: Binder<Bool> {
        return Binder(self) { _self, isBack in
            _self.opponentCardsViews.forEach { $0.isBack = isBack }
        }
    }
    
    @objc private func selectCard(_ sender: UITapGestureRecognizer) {
        userCardViews.filter { $0.tag == sender.view?.tag }.forEach { $0.isSelected = !$0.isSelected }
        guard let cardView = sender.view as? CardView else { return }
        presenter.switchIsSelectCard(tag: cardView.tag, isSelected: cardView.isSelected)
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        tradeButton.isEnabled = true
        sender.isEnabled = false
        setSelectable(true)
        presenter.postTapStartButton()
        let bet = presenter.walletContent()
        let betPickerVC = BetPickerViewController.instantiate(possessionMoney: bet) { [weak self] bet in
            self?.start(bet: bet)
        }
        present(betPickerVC, animated: true)
    }
    
    func start(bet: Int) {
        presenter.postStart(bet: bet)
    }
    
    @IBAction private func tapTradeButton(_ sender: UIButton) {
        startButton.isEnabled = true
        sender.isEnabled = false
        setSelectable(false)
        presenter.postTrade()
    }
    
    func setSelectable(_ selectable: Bool) {
        userCardViews.forEach { $0.isUserInteractionEnabled = selectable }
    }
}
