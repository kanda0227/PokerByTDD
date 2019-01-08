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
    
    public func musicPlay(_ audio: MusicAudio? = nil) {
        
        let music = audio ?? currentMusic()
        
        guard isOnMusicSwitch() else {
            return
        }
        
        guard let path = Bundle.main.path(forResource: music.rawValue, ofType: MusicAudio.type()) else {
            fatalError("音楽リソースを用意しておくれ")
        }
        
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        
        musicPlayer?.delegate = self
        musicPlayer?.numberOfLoops = -1
        musicPlayer?.volume = musicVolumeValue()
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
        UserDefaults.standard.set(volume, forKey: musicVolumeKey)
        resetMusicPlayer()
    }
    
    public func setMusic(_ music: MusicAudio) {
        UserDefaults.standard.set(music.rawValue, forKey: musicKey)
        resetMusicPlayer()
    }
    
    public func isOnMeowSwitch() -> Bool {
        return UserDefaults.standard.value(forKey: shouldMeowKey) as? Bool ?? true
    }
    
    public func isOnMusicSwitch() -> Bool {
        return UserDefaults.standard.value(forKey: shouldPlayMusicKey) as? Bool ?? true
    }
    
    public func musicVolumeValue() -> Float {
        return UserDefaults.standard.value(forKey: musicVolumeKey) as? Float ?? 1.0
    }
    
    public func currentMusic() -> MusicAudio {
        let rawValue = UserDefaults.standard.string(forKey: musicKey)
        return rawValue.flatMap(MusicAudio.init) ?? ._default
    }
    
    private func resetMusicPlayer() {
        
        musicPlayer?.stop()
        
        guard isOnMusicSwitch() else {
            return
        }
        
        musicPlay(currentMusic())
    }
}

public enum NekoAudio: String {
    case meow
    
    fileprivate static func type() -> String? {
        return "mp3"
    }
}

public enum MusicAudio: String, CaseIterable {
    case aquarium
    case hidamari
    
    public static let _default: MusicAudio = .aquarium
    
    fileprivate static func type() -> String? {
        return "mp3"
    }
    
    public func musicName() -> String {
        switch self {
        case .aquarium:
            return "水族館"
        case .hidamari:
            return "ひだまり"
        }
    }
}
