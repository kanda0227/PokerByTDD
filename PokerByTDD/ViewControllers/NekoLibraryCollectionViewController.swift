//
//  NekoLibraryCollectionViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/09.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Model
import Utility
import Design
import Presenter
import RxSwift

final class NekoLibraryCollectionViewController: UICollectionViewController, ColorSetViewProtocol {
    
    private let bag = DisposeBag()
    
    private lazy var presenter = NekoLibraryPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(NekoLibraryCell.self)
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
        collectionView.backgroundColor = colorSet.backgroundColor()
        collectionView.visibleCells.map { ($0, collectionView.indexPath(for: $0)) }.forEach { elems in
            guard let cell = elems.0 as? NekoLibraryCell,
                let indexPath = elems.1 else { return }
            cell.set(neko: presenter.neko(at: indexPath), colorSet: colorSet)
        }
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NekoLibraryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(neko: presenter.neko(at: indexPath), colorSet: ColorSet.restore())
        return cell
    }
    
    override func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let nekoDetailVC = NekoDetailViewController.instantiate(neko: presenter.neko(at: indexPath))
        // ここで直接 present するとタブバーが表示されてしまい，
        // モーダル画面を開いた状態でのタブバー移動ができてしまうため
        // バグの素になりそうなのでタブバーに present させる
        UIApplication.shared.keyWindow?.rootViewController?.present(nekoDetailVC, animated: true)
    }
}
