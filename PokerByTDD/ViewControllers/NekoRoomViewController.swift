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
    
    private let bag = DisposeBag()
    
    private var nekoWalkDisposable: Disposable?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nekoImage.addGestureRecognizer(UITapGestureRecognizer(target: self, action: #selector(NekoRoomViewController.tapNeko)))
        eventDisposable().disposed(by: bag)
        nekoImage.action(.frolic)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        super.viewDidAppear(animated)
        Neko.selectedNeko().map(nekoImage.set)
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
    }
    
    @objc private func tapNeko(_ sender: UITapGestureRecognizer) {
        nekoImage.action(.meow)
    }
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
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
}
