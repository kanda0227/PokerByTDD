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
import Model
import Presenter
import Design
import Utility

/// ポーカー画面
final class PokerViewController: UIViewController, ColorSetViewProtocol {
    
    /// ユーザーのカードのビュー
    @IBOutlet private var userCardViews: [CardView]!
    /// ユーザーの役を表示するラベル
    @IBOutlet private weak var userHandLabel: CustomLabel!
    /// 対戦相手のカードのビュー
    @IBOutlet private var opponentCardsViews: [CardView]!
    /// 対戦相手の役を表示するラベル
    @IBOutlet private weak var opponentHandLabel: CustomLabel!
    /// 対戦結果を表示するラベル
    @IBOutlet private weak var resultLabel: CustomLabel!
    @IBOutlet private weak var startButton: CustomButton!
    @IBOutlet private weak var tradeButton: CustomButton!
    /// 所持金を表示するラベル
    @IBOutlet private weak var walletView: WalletView!
    
    private let bag = DisposeBag()
    
    private var presenter: PokerViewPresenter!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        presenter = PokerViewPresenter(updateCards: updateCards,
                                       handText: handText,
                                       wallet: walletBinder, turnOverUserCards: turnOverUserCards,
                                       turnOverOpponentCards: turnOverOpponentCards,
                                       switchSelectableCards: switchSelectableCards,
                                       switchIsStartButtonEnabled: switchIsStartButtonEnabled,
                                       switchIsTradeButtonEnabled: switchIsTradeButtonEnabled)
        userCardViews.forEach { $0.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(PokerViewController.selectCard))) }
        setSelectable(false)
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupColor()
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
        (userCardViews + opponentCardsViews).forEach { $0.reloadColor(colorSet: colorSet) }
        walletView.set(colorSet: colorSet)
        tradeButton.colorSet = colorSet
        startButton.colorSet = colorSet
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        (userCardViews + opponentCardsViews).forEach {
            $0.reset(back: CardImageHelper.shared.backImage(), card: CardImageHelper.shared.cardImage($0.card))
        }
    }
    
    private var updateCards: Binder<(cards: [Card], opponentCards: [Card])> {
        return Binder(self) { _self, params in
            let (cards, opponentCards) = params
            _self.userCardViews.configure(cards: cards)
            _self.opponentCardsViews.configure(cards: opponentCards)
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
    
    private var walletBinder: Binder<(money: Int, count: Int, perTime: Int, shouldPresentMoney: Bool)> {
        return Binder(walletView) { walletView, elems in
            walletView.money = elems.money
            walletView.set(second: elems.count, presentMoneyPerTime: elems.perTime, shouldPresentMoney: elems.shouldPresentMoney)
        }
    }
    
    private var turnOverUserCards: Binder<Bool> {
        return Binder(self) { _self, isBack in
            _self.userCardViews.turnOver(isBack: isBack)
        }
    }
    
    private var turnOverOpponentCards: Binder<Bool> {
        return Binder(self) { _self, isBack in
            _self.opponentCardsViews.turnOver(isBack: isBack)
        }
    }
    
    private var switchSelectableCards: Binder<Bool> {
        return Binder(self) { _self, selectable in
            _self.setSelectable(selectable)
        }
    }
    
    private var switchIsStartButtonEnabled: Binder<Bool> {
        return Binder(self) { _self, isEnabled in
            _self.startButton.isEnabled = isEnabled
        }
    }
    
    private var switchIsTradeButtonEnabled: Binder<Bool> {
        return Binder(self) { _self, isEnabled in
            _self.tradeButton.isEnabled = isEnabled
        }
    }
    
    @objc private func selectCard(_ sender: UITapGestureRecognizer) {
        userCardViews.filter { $0.tag == sender.view?.tag }.forEach { $0.isSelected = !$0.isSelected }
        guard let cardView = sender.view as? CardView else { return }
        presenter.switchIsSelectCard(tag: cardView.tag, isSelected: cardView.isSelected)
    }
    
    @IBAction func tapStartButton(_ sender: UIButton) {
        presenter.postTapStartButton()
        let betPickerVC = BetPickerViewController
            .instantiate(possessionMoney: presenter.walletContent()) { [weak self] bet in
            self?.presenter.postStart(bet: bet)
        }
        present(betPickerVC, animated: true)
    }
    
    @IBAction private func tapTradeButton(_ sender: UIButton) {
        presenter.postTrade()
    }
    
    func setSelectable(_ selectable: Bool) {
        userCardViews.forEach { $0.isUserInteractionEnabled = selectable }
    }
}

private extension Array where Element==CardView {
    
    func configure(cards: [Card]) {
        cards.enumerated().forEach { index, card in
            let cardView = filter { $0.tag == index }.first
            cardView?.setCard(card, cardImage: CardImageHelper.shared.cardImage(card))
            cardView?.isSelected = false
        }
    }
    
    func turnOver(isBack: Bool) {
        forEach { $0.isBack = isBack }
    }
}
