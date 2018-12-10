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

final class NekoLibraryCollectionViewController: UICollectionViewController {
    
    private lazy var presenter = NekoLibraryPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(NekoLibraryCell.self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return presenter.numberOfItemsInSection(section)
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NekoLibraryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(neko: presenter.neko(at: indexPath))
        return cell
    }
}
