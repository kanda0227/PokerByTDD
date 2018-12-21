//
//  NekoAnimateView.swift
//  Design
//
//  Created by Kanda Sena on 2018/12/14.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model

/// ねこのアニメーション付きの ImageView (鳴く動作)
///
/// 後々鳴き声もつけてほしい
@IBDesignable public final class NekoAnimateView: UIImageView {
    
    private var contentSize: CGSize!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    private func configure() {
        contentSize = bounds.size
    }
    
    /// 画像のセット作業
    ///
    /// これを呼ばないとアニメーションしません
    public func set(neko: Neko) {
        image = neko.image()
        highlightedAnimationImages = NekoAction.meow.animateImage(neko: neko)
        animationDuration = 1
        animationRepeatCount = 1
    }
    
    public func actionTapped() {
        isHighlighted = true
        startAnimating()
    }
    
    public override var intrinsicContentSize: CGSize {
        return contentSize
    }
}
