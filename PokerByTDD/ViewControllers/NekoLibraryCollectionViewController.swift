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

final class NekoLibraryCollectionViewController: UICollectionViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        collectionView.register(NekoLibraryCell.self)
    }
    
    override func numberOfSections(in collectionView: UICollectionView) -> Int {
        return 1
    }
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Neko.allCases.count
    }
    
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell: NekoLibraryCell = collectionView.dequeueReusableCell(for: indexPath)
        cell.set(neko: Neko.allCases[indexPath.item])
        return cell
    }
}
