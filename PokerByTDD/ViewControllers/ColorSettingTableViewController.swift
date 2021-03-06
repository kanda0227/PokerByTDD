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
import RxSwift
import Model

final class ColorSettingTableViewController: UITableViewController, ColorSetViewProtocol {
    
    private let bag = DisposeBag()
    
    private lazy var presenter = ColorSettingPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.register(ColorSettingCell.self)
        eventDisposable().disposed(by: bag)
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
        tableView.selectRow(at: presenter.selectedIndex(), animated: false, scrollPosition: .top)
        if let indexPath = presenter.selectedIndex() {
            (tableView.cellForRow(at: indexPath) as? ColorSettingCell)?.selected(true)
        }
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
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
    
    override func tableView(_ tableView: UITableView, willSelectRowAt indexPath: IndexPath) -> IndexPath? {
        if let selectedIndexPath = tableView.indexPathForSelectedRow {
            (tableView.cellForRow(at: selectedIndexPath) as? ColorSettingCell)?.selected(false)
        }
        return indexPath
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        presenter.didSelect(at: indexPath)
        (tableView.cellForRow(at: indexPath) as? ColorSettingCell)?.selected(true)
    }
}
