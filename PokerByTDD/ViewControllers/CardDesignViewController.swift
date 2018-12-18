//
//  CardDesignViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/02.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import UIKit
import Presenter
import Design
import RxSwift
import Model

final class CardDesignViewController: UIViewController, ColorSetViewProtocol {
    
    @IBOutlet private weak var tableView: UITableView! {
        didSet {
            tableView.register(SettingItemCell.self)
        }
    }
    
    private let bag = DisposeBag()
    
    private lazy var presenter = CardDesignPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        eventDisposable().disposed(by: bag)
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        if let indexPath = tableView.indexPathForSelectedRow {
            tableView.deselectRow(at: indexPath, animated: true)
        }
    }
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
        tableView.backgroundColor = colorSet.backgroundColor()
    }
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
