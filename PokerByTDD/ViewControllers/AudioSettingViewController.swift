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
import Presenter

final class AudioSettingViewController: UIViewController, ColorSetViewProtocol {
    
    @IBOutlet private weak var meowSwitch: UISwitch!
    @IBOutlet private weak var musicSwitch: UISwitch!
    @IBOutlet private weak var musicSlider: UISlider!
    @IBOutlet private weak var musicSelectTextField: UITextField!
    private var picker: UIPickerView?
    private lazy var presenter = AudioSettingPresenter()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupPickerView()
    }
    
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
        musicSelectTextField.tintColor = colorSet.navigationBarColor()
        musicSelectTextField.backgroundColor = colorSet.backgroundColor()
    }
    
    @IBAction private func tapMeowSwitch(sender: UISwitch) {
        AudioHelper.shared.setIsOnMeowSwitch(sender.isOn)
    }
    
    @IBAction private func tapMusicSwitch(_ sender: UISwitch) {
        AudioHelper.shared.setIsOnMusicSwitch(sender.isOn)
    }
    
    @IBAction private func slideMusicSlide(_ sender: UISlider) { AudioHelper.shared.setMusicVolume(sender.value)
    }
    
    private func setup() {
        meowSwitch.isOn = AudioHelper.shared.isOnMeowSwitch()
        musicSwitch.isOn = AudioHelper.shared.isOnMusicSwitch()
        musicSlider.value = AudioHelper.shared.musicVolumeValue()
        musicSelectTextField.text = AudioHelper.shared.currentMusic().musicName()
    }
    
    private func setupPickerView() {
        picker = UIPickerView()
        picker?.delegate = self
        picker?.dataSource = self
        picker?.showsSelectionIndicator = true
        
        let toolbar = UIToolbar(frame: CGRect(x: 0, y: 0, width: 0, height: 35))
        let doneButton = UIBarButtonItem(barButtonSystemItem: .done, target: self, action: #selector(AudioSettingViewController.doneSelectMusic))
        let cancelButton = UIBarButtonItem(barButtonSystemItem: .cancel, target: self, action: #selector(AudioSettingViewController.cancelSelectMusic))
        toolbar.setItems([cancelButton, doneButton], animated: true)
        
        self.musicSelectTextField.inputView = picker
        self.musicSelectTextField.inputAccessoryView = toolbar
    }
    
    @objc private func doneSelectMusic() {
        let selectedMusic = (picker?.selectedRow(inComponent: 0)).flatMap { MusicAudio.allCases[$0] }
        musicSelectTextField.text = selectedMusic?.musicName()
        selectedMusic.map(AudioHelper.shared.setMusic)
        musicSelectTextField.endEditing(true)
    }
    
    @objc private func cancelSelectMusic() {
        musicSelectTextField.endEditing(true)
    }
}

extension AudioSettingViewController: UIPickerViewDelegate {}

extension AudioSettingViewController: UIPickerViewDataSource {
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return presenter.numberOfComponents()
    }
    
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return presenter.numberOfRowsInComponent(component)
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return presenter.title(row: row, component: component)
    }
}
