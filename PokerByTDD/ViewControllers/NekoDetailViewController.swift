//
//  NekoDetailViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/12.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import UIKit
import Model
import Design
import RxSwift

/// ねこ詳細画面
///
/// 将来的にはもっと表示する情報増やしたいね
final class NekoDetailViewController: UIViewController, ColorSetViewProtocol {
    
    /// ファクトリーメソッド
    ///
    /// Neko オブジェクトを渡すと該当のねこ情報を表示します
    static func instantiate(neko: Neko) -> NekoDetailViewController {
        
        let vc = UIStoryboard(name: "NekoDetailView", bundle: nil).instantiateInitialViewController() as! NekoDetailViewController
        
        vc.modalPresentationStyle = .overCurrentContext
        vc.modalTransitionStyle = .crossDissolve
        
        vc.neko = neko
        
        return vc
    }
    
    @IBOutlet private weak var mainView: UIView! {
        didSet {
            mainView.layer.borderColor = UIColor(named: "pink")?.cgColor
            mainView.layer.borderWidth = 5
            mainView.layer.cornerRadius = 7
        }
    }
    @IBOutlet private weak var chooseButton: UIButton! {
        didSet {
            chooseButton.isEnabled = neko != .unknown
        }
    }
    @IBOutlet private weak var nekoImageView: NekoAnimateView! {
        didSet {
            nekoImageView.set(neko: neko)
        }
    }
    @IBOutlet private weak var nekoLabel: UILabel! {
        didSet {
            nekoLabel.text = neko.name
        }
    }
    @IBOutlet private weak var backView: UIView! {
        didSet {
            backView.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NekoDetailViewController.tapBackView)))
        }
    }
    
    private let bag = DisposeBag()
    
    private var neko: Neko!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        setupColor()
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
    }
    
    @objc private func tapBackView(_ sender: UITapGestureRecognizer) {
        dismissView()
    }
    
    @IBAction private func tapChooseButton(_ sender: Any) {
        nekoImageView.action()
        neko.select()
    }
    
    @IBAction private func tapDismissButton(_ sender: Any) {
        dismissView()
    }
    
    private func dismissView() {
        dismiss(animated: true, completion: nil)
    }
}
