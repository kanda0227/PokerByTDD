//
//  CardView.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/11/20.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model

@IBDesignable public final class CardView: UIView {
    
    private var contentSize: CGSize!
    @IBOutlet private weak var rankLabel: CustomLabel!
    @IBOutlet private weak var rankBackLabel: CustomLabel!
    @IBOutlet private weak var suitLabel: CustomLabel!
    @IBOutlet private weak var suitBackLabel: CustomLabel!
    @IBOutlet private weak var backView: UIImageView!
    @IBOutlet private weak var cardImageView: UIImageView!
    
    public private(set) var card: Card?
    private var currentColorSet: ColorSet = .default
    
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
    
    public func setCard(_ card: Card?, cardImage: UIImage?) {
        self.card = card
        let shouldHiddenLabels = card == nil
        rankLabel?.isHidden = shouldHiddenLabels
        suitLabel?.isHidden = shouldHiddenLabels
        guard let card = card else { return }
        setRank(card)
        setSuit(card)
        cardImageView.image = cardImage
    }
    
    private func setRank(_ card: Card) {
        rankLabel.text = card.rank.rawValue
        rankLabel.textColor = card.suit.color()
        rankBackLabel.text = card.rank.rawValue
    }
    
    private func setSuit(_ card: Card) {
        let suit = card.suit
        suitLabel.text = suit.rawValue
        suitLabel.textColor = suit.color()
        suitBackLabel.text = suit.rawValue
    }
    
    public func setColor(colorSet: ColorSet) {
        switchCardBorderColor(colorSet: colorSet)
        self.currentColorSet = colorSet
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
    
    private func switchCardBorderColor(colorSet: ColorSet? = nil) {
        let colorSet = colorSet ?? currentColorSet
        let color = isSelected ? colorSet.tabBarColor() : colorSet.navigationBarColor()
        let borderWidth: CGFloat = isSelected ? 4 : 2
        let cornerRadius: CGFloat = 5
        
        self.layer.borderColor = color.cgColor
        self.layer.borderWidth = borderWidth
        self.layer.cornerRadius = cornerRadius
        self.backView.layer.cornerRadius = cornerRadius
        self.cardImageView.layer.cornerRadius = cornerRadius
    }
    
    public func reset(back: UIImage?, card: UIImage?) {
        if let back = back {
            /// 裏面のビューは nil もセットしちゃうとカード丸見えになっちゃうからね
            backView.image = back
        }
        cardImageView.image = card
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
