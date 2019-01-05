//
//  AudioHelper.swift
//  Model
//
//  Created by Kanda Sena on 2019/01/01.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import AVFoundation

public final class AudioHelper: NSObject, AVAudioPlayerDelegate {
    
    private let shouldMeowKey = "shouldMeowKey"
    private let shouldPlayMusicKey = "shouldPlayMusicKey"
    private let musicVolumeKey = "musicVolumeKey"
    private let musicKey = "musicKey"
    
    private var nekoAudioPlayer: AVAudioPlayer?
    
    private var musicPlayer: AVAudioPlayer?
    
    private var musicVolume: Float = 1.0
    
    private var music: MusicAudio = .test
    
    public static let shared = AudioHelper()
    
    public func nekoPlay(_ audio: NekoAudio) {
        
        guard isOnMeowSwitch() else { return }
        
        guard let path = Bundle.main.path(forResource: audio.rawValue, ofType: NekoAudio.type()) else {
            fatalError("音声リソースを用意しておくれ")
        }
        
        nekoAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        
        nekoAudioPlayer?.delegate = self
        nekoAudioPlayer?.play()
    }
    
    public func musicPlay(_ audio: MusicAudio) {
        
        guard isOnMusicSwitch() else {
            return
        }
        
        guard let path = Bundle.main.path(forResource: audio.rawValue, ofType: MusicAudio.type()) else {
            fatalError("音楽リソースを用意しておくれ")
        }
        
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        
        musicPlayer?.delegate = self
        musicPlayer?.numberOfLoops = -1
        musicPlayer?.volume = musicVolume
        musicPlayer?.play()
    }
    
    public func setIsOnMeowSwitch(_ shouldSound: Bool) {
        UserDefaults.standard.set(shouldSound, forKey: shouldMeowKey)
    }
    
    public func setIsOnMusicSwitch(_ shouldSound: Bool) {
        UserDefaults.standard.set(shouldSound, forKey: shouldPlayMusicKey)
        resetMusicPlayer()
    }
    
    public func setMusicVolume(_ volume: Float) {
        self.musicVolume = volume
        resetMusicPlayer()
    }
    
    public func setMusic(_ music: MusicAudio) {
        self.music = music
        resetMusicPlayer()
    }
    
    public func isOnMeowSwitch() -> Bool {
        return UserDefaults.standard.bool(forKey: shouldMeowKey)
    }
    
    public func isOnMusicSwitch() -> Bool {
        return UserDefaults.standard.bool(forKey: shouldPlayMusicKey)
    }
    
    public func musicVolumeValue() -> Float {
        return musicVolume
    }
    
    private func resetMusicPlayer() {
        guard let musicPlayer = musicPlayer else { return }
        
        musicPlayer.stop()
        
        guard isOnMusicSwitch() else {
            return
        }
        
        musicPlayer.volume = musicVolume
        musicPlayer.play()
    }
}

public enum NekoAudio: String {
    case meow
    
    fileprivate static func type() -> String? {
        return "mp3"
    }
}

public enum MusicAudio: String {
    case test
    
    fileprivate static func type() -> String? {
        return "mp3"
    }
}
