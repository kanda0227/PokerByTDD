//
//  CardView.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/20.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import RealmSwift
import Model
import Presenter

@IBDesignable public final class CardView: UIView {
    
    let realm = try! Realm()
    
    private var contentSize: CGSize!
    @IBOutlet private weak var rankLabel: UILabel! {
        didSet {
            setCard(card)
        }
    }
    @IBOutlet private weak var rankBackLabel: UILabel!
    @IBOutlet private weak var suitLabel: UILabel! {
        didSet {
            setCard(card)
        }
    }
    @IBOutlet private weak var suitBackLabel: UILabel!
    @IBOutlet private weak var backView: UIImageView!
    @IBOutlet private weak var cardImageView: UIImageView!
    
    public var card: Card? {
        didSet {
            setCard(card)
        }
    }
    
    @IBInspectable public var isBack: Bool = true {
        didSet {
            backView.isHidden = !isBack
        }
    }
    
    public var isSelected: Bool = false {
        didSet {
            switchCardBorderColor()
        }
    }
    
    private func setCard(_ card: Card?) {
        let shouldHiddenLabels = card == nil
        rankLabel?.isHidden = shouldHiddenLabels
        suitLabel?.isHidden = shouldHiddenLabels
        guard let card = card else { return }
        let rank = card.rank
        let suit = card.suit
        rankLabel.text = rank.rawValue
        rankLabel.textColor = suit.color()
        rankBackLabel.text = rank.rawValue
        suitLabel.text = suit.rawValue
        suitLabel.textColor = suit.color()
        suitBackLabel.text = suit.rawValue
        setupCardImageView()
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func instantiate() -> UIView {
    return UINib(nibName: "CardView", bundle: Bundle(for: CardView.self))
        .instantiate(withOwner: self, options: nil)
        .first as! UIView
    }
    
    // イニシャライザの共通処理
    private func configure() {
        let view = instantiate()
        view.frame = bounds
        self.addSubview(view)
        contentSize = bounds.size
        switchCardBorderColor()
        backView.clipsToBounds = true
    }
    
    override public var intrinsicContentSize: CGSize {
        return contentSize
    }
    
    private func switchCardBorderColor() {
        let colorName = isSelected ? "green" : "pink"
        let borderWidth: CGFloat = isSelected ? 4 : 2
        let cornerRadius: CGFloat = 5
        
        self.layer.borderColor = UIColor(named: colorName)?.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.backView.layer.cornerRadius = cornerRadius
        self.cardImageView.layer.cornerRadius = cornerRadius
    }
    
    public func reload() {
        setupCardBackView()
        setupCardImageView()
    }
    
    private func setupCardBackView() {
        if let image = try! Realm().restoreImage(key: CardDesignCategory.back.key()) {
            backView.image = image
        }
    }
    
    private func setupCardImageView() {
        // 該当のカテゴリキーの画像を一旦全部復元させているので
        // パフォーマンスが悪い気がするが，現状では高々2つなのでこのままにしておく
        cardImageView.image = card?.category.compactMap { realm.restoreImage(key: $0.key()) }.first
    }
}

private extension Card.Suit {
    
    func color() -> UIColor {
        switch self {
        case .club, .spade:
            return .black
        case .diamond, .heart:
            return .red
        }
    }
}