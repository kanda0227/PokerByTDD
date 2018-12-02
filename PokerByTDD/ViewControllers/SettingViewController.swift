//
//  SettingViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit

/// 設定画面のVC
final class SettingViewController: UIViewController {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(SettingItemCell.self)
        }
    }
    
    private lazy var presenter = SettingPresenter()
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
}

extension SettingViewController: UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection()
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: SettingItemCell = tableView.dequeueReusableCell(for: indexPath)
        let item = presenter.item(at: indexPath)
        cell.set(itemName: item.itemName)
        return cell
    }
}

extension SettingViewController: UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let item = presenter.item(at: indexPath)
        if let vc = UIViewController.instantiate(withStoryboardID: item.storyboardID) {
            vc.title = item.itemName
            navigationController?.pushViewController(vc, animated: true)
        }
    }
}
