//
//  NekoRoomViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/16.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model
import Design
import RxSwift
import Utility

final class NekoRoomViewController: UIViewController, ColorSetViewProtocol {
    
    @IBOutlet private weak var nekoImage: NekoAnimateView!
    @IBOutlet private weak var notSelectedNekoView: CustomView!
    @IBOutlet private weak var selectedNekoLabel: CustomLabel!
    @IBOutlet private weak var selectButton: CommonDesignButton!
    
    private var selectedNeko: Neko? {
        didSet {
            selectedNeko.map(nekoImage.set)
            let isSelectedNeko = (selectedNeko != .unknown && selectedNeko != nil)
            notSelectedNekoView.isHidden = isSelectedNeko
            nekoImage.isHidden = !isSelectedNeko
        }
    }
    
    private let bag = DisposeBag()
    
    private var nekoWalkDisposable: Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nekoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NekoRoomViewController.tapNeko)))
        nekoImage.addGestureRecognizer(UILongPressGestureRecognizer(target: self, action: #selector(NekoRoomViewController.longPressNeko)))
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        selectedNeko = Neko.selectedNeko()
        nekoImage.action(.sit)
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
        notSelectedNekoView.reloadColor(colorSet: colorSet)
        selectButton.colorSet = colorSet
        selectedNekoLabel.reloadColor(colorSet: colorSet)
    }
    
    @objc private func tapNeko(_ sender: UITapGestureRecognizer) {
        // ねこを選択していない場合はタップ無効
        guard let selectedNeko = selectedNeko, selectedNeko != .unknown else { return }
        nekoImage.action(.meow)
    }
    
    @objc private func longPressNeko(_ sender: UILongPressGestureRecognizer) {
        // ねこを選択していない場合はロングタップ無効
        guard let selectedNeko = selectedNeko, selectedNeko != .unknown else { return }
        if sender.state == .began {
            nekoImage.action(.frolic)
        }
        if sender.state == .ended {
            nekoImage.action(.sit)
        }
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        // ねこを選択していない場合はタップでの移動無効
        guard let selectedNeko = selectedNeko, selectedNeko != .unknown else { return }
        
        guard event?.touches(for: nekoImage) == nil else { return }
        
        guard let goalPoint = event?.allTouches?.first?.location(in: self.view) else { return }
        
        let startPoint = nekoImage.center
        NekoWalkCalculation.shared.stop()
        NekoWalkCalculation.shared.walk(startPoint: startPoint, goalPoint: goalPoint)
        nekoImage.action(.walk(NekoWalkCalculation.shared.walkDirection()))
        let disposables = [
            NekoWalkCalculation.shared.walkObservable().subscribe(onNext: { [weak self] point in
                self?.nekoWalk(point)
            }),
            NekoWalkCalculation.shared.stopObservable().subscribe(onNext: { [weak self] in
                self?.nekoWalkDisposable?.dispose()
                self?.nekoImage?.action(.sit)
            })
            ]
        nekoWalkDisposable = Disposables.create(disposables)
        
    }
    
    private func nekoWalk(_ point: CGPoint) {
        UIView.animate(withDuration: NekoWalkCalculation.shared.interval, delay: 0.0, animations: { [weak self] in
            self?.nekoImage.center = point
        }, completion: nil)
    }
    
    @IBAction private func tapSelectNekoButton(_ sender: Any) {
        if Neko.allHasNekos.isEmpty {
            AutomaticTransitionHelper.shared.post(.nekoGacha)
        } else {
            AutomaticTransitionHelper.shared.post(.nekoLibrary)
        }
    }
}
