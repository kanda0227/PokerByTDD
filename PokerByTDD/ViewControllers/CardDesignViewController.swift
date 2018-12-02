//
//  CardDesignViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

final class CardDesignViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(SettingItemCell.self)
        }
    }
    
    private lazy var presenter = CardDesignPresenter()
}

extension CardDesignViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let item = presenter.item(at: indexPath)
        let cell: SettingItemCell = tableView.dequeueReusableCell(for: indexPath)
        cell.set(itemName: item.rawValue)
        return cell
    }
}

extension CardDesignViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let vc = CardDesignChoiceViewController.instantiate(category: presenter.item(at: indexPath))
        navigationController?.pushViewController(vc, animated: true)
    }
}
