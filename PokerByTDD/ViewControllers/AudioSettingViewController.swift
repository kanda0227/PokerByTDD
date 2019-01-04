//
//  AudioSettingViewController.swift
//  PokerByTDD
//
//  Created by Kanda Sena on 2019/01/03.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import UIKit
import Utility
import Model

final class AudioSettingViewController: UIViewController, ColorSetViewProtocol {
    
    @IBOutlet private weak var meowSwitch: UISwitch!
    @IBOutlet private weak var musicSwitch: UISwitch!
    @IBOutlet private weak var musicSlider: UISlider!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
        setup()
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
    }
    
    @IBAction private func tapMeowSwitch(sender: UISwitch) {
        AudioHelper.shared.setIsOnMeowSwitch(sender.isOn)
    }
    
    @IBAction private func tapMusicSwitch(_ sender: Any) {
    }
    
    @IBAction func slideMusicSlide(_ sender: Any) {
    }
    
    private func setup() {
        meowSwitch.isOn = AudioHelper.shared.isOnMeowSwitch()
    }
}
