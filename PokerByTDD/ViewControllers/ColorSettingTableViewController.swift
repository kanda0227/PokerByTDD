//
//  ColorSettingTableViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/15.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Design
import Presenter

final class ColorSettingTableViewController: UITableViewController {
    
    private lazy var presenter = ColorSettingPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ColorSettingCell.self)
    }
    
    override func numberOfSections(in tableView: UITableView) -> Int {
        return presenter.numberOfSections()
    }
    
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return presenter.numberOfRowsInSection(section)
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ColorSettingCell = tableView.dequeueReusableCell(for: indexPath)
        cell.set(presenter.item(at: indexPath))
        return cell
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath)
    }
}
