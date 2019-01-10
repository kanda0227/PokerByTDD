//
//  InputPickerAccessoryView.swift
//  Design
//
//  Created by Kanda Sena on 2019/01/10.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Model

public final class InputPickerAccessoryView: UIView, ColorSetViewProtocol {
    
    @IBOutlet public private(set) var cancelButton: CustomButton!
    @IBOutlet public private(set) var doneButton: CustomButton!
    
    public convenience init() {
        self.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height: 44))
    }
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        configure()
    }
    
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        configure()
    }
    
    public func reloadColor(colorSet: ColorSet) {
        subviews.forEach {  $0.backgroundColor = colorSet.navigationBarColor() }
        cancelButton.setTitleColor(colorSet.backgroundColor(), for: .normal)
        doneButton.setTitleColor(colorSet.backgroundColor(), for: .normal)
    }
    
    private func instantiate() -> UIView {
        return UINib(nibName: "InputPickerAccessoryView", bundle: Bundle(for: InputPickerAccessoryView.self))
            .instantiate(withOwner: self, options: nil)
            .first as! UIView
    }
    
    public override var intrinsicContentSize: CGSize {
        return CGSize(width: UIScreen.main.bounds.width, height: 44)
    }
    
    // イニシャライザの共通処理
    private func configure() {
        let view = instantiate()
        view.frame = bounds
        self.addSubview(view)
    }
}
