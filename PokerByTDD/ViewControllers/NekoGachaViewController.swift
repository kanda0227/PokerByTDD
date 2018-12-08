//
//  NekoGachaViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2018/12/08.
//  Copyright © 2018 sena.kanda. All rights reserved.
//

import Foundation
import UIKit
import Model

final class NekoGachaViewController: UIViewController {
    
    @IBOutlet private weak var nekoImageView: UIImageView!
    @IBOutlet private weak var nekoLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        nekoImageView.image = nil
        nekoLabel.text = nil
    }
    
    @IBAction private func tapGachaButton(sender: Any) {
        let neko = NekoGacha.shared.get()
        nekoImageView.image = neko.image
        nekoLabel.text = neko.name
    }
}

private extension Neko {
    var image: UIImage {
        switch self {
        case .mike:
            return #imageLiteral(resourceName: "mike_neko_sit1")
        case .black:
            return #imageLiteral(resourceName: "kuro_neko_sit1")
        case .white:
            return #imageLiteral(resourceName: "siro_neko_sit1")
        case .russianBlue:
            return #imageLiteral(resourceName: "rosian_neko_sit1")
        case .socks:
            return #imageLiteral(resourceName: "kutsusita_neko_sit1")
        }
    }
}
