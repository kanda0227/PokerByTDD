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
import Design

final class AudioSettingViewController: UIViewController, ColorSetViewProtocol {
    
    @IBOutlet private weak var meowSwitch: UISwitch!
    @IBOutlet private weak var musicSwitch: UISwitch!
    @IBOutlet private weak var musicSlider: UISlider!
    @IBOutlet private weak var musicSelectButton: SelectButton!
    
    override func viewDidLayoutSubviews() {
        super.viewDidLayoutSubviews()
        setupColor()
        setup()
    }
    
    func reloadColor(colorSet: ColorSet) {
        commonSetupColor(colorSet: colorSet)
        meowSwitch.onTintColor = colorSet.tabBarColor()
        musicSwitch.onTintColor = colorSet.tabBarColor()
        musicSlider.tintColor = colorSet.tabBarColor()
        musicSelectButton.layer.borderColor = colorSet.navigationBarColor().cgColor
        musicSelectButton.layer.borderWidth = 2
        musicSelectButton.colorSet = colorSet
    }
    
    @IBAction private func tapMeowSwitch(sender: UISwitch) {
        AudioHelper.shared.setIsOnMeowSwitch(sender.isOn)
    }
    
    @IBAction private func tapMusicSwitch(_ sender: UISwitch) {
        AudioHelper.shared.setIsOnMusicSwitch(sender.isOn)
    }
    
    @IBAction private func slideMusicSlide(_ sender: UISlider) { AudioHelper.shared.setMusicVolume(sender.value)
    }
    
    @IBAction private func tapMusicSelectButton(_ sender: UIButton) {
        
    }
    
    private func setup() {
        meowSwitch.isOn = AudioHelper.shared.isOnMeowSwitch()
        musicSwitch.isOn = AudioHelper.shared.isOnMusicSwitch()
        musicSlider.value = AudioHelper.shared.musicVolumeValue()
        musicSelectButton.titleLabel?.text = AudioHelper.shared.currentMusic().musicName()
    }
}
