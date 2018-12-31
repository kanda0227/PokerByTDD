//
//  ShopViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/30.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Model
import Presenter
import Design

final class ShopViewController: UICollectionViewController, ColorSetViewProtocol {
    
    private lazy var presenter = ShopPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        setupColor()
        collectionView.register(ShopCell.self)
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: ShopCell = collectionView.dequeueReusableCell(for: indexPath)
        let item = presenter.item(at: indexPath)
        cell.set(itemName: item.name, image: item.image)
        return cell
    }
}

extension ShopViewController: UICollectionViewDelegateFlowLayout {
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let margin: CGFloat = 30
        let width = (UIScreen.main.bounds.size.width - margin) / 2
        let height: CGFloat = 79
        return CGSize(width: width, height: height)
    }
}
