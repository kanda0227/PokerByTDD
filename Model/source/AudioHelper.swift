//
//  AudioHelper.swift
//  Model
//
//  Created by Kanda Sena on 2019/01/01.
//  Copyright © 2019 sena.kanda. All rights reserved.
//

import AVFoundation

public final class AudioHelper: NSObject, AVAudioPlayerDelegate {
    
    private var nekoAudioPlayer: AVAudioPlayer?
    
    private var musicPlayer: AVAudioPlayer?
    
    private var shouldMeow: Bool = true
    
    private var shouldPlayMusic: Bool = true {
        didSet {
            resetMusicPlayer()
        }
    }
    
    private var musicVolume: Float = 1.0 {
        didSet {
            resetMusicPlayer()
        }
    }
    
    public static let shared = AudioHelper()
    
    public func nekoPlay(_ audio: NekoAudio) {
        
        guard shouldMeow else { return }
        
        guard let path = Bundle.main.path(forResource: audio.rawValue, ofType: NekoAudio.type()) else {
            fatalError("音声リソースを用意しておくれ")
        }
        
        nekoAudioPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        
        nekoAudioPlayer?.delegate = self
        nekoAudioPlayer?.play()
    }
    
    public func musicPlay(_ audio: MusicAudio) {
        
        guard shouldPlayMusic else {
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
        self.shouldMeow = shouldSound
    }
    
    public func setIsOnMusicSwitch(_ shouldSound: Bool) {
        self.shouldPlayMusic = shouldSound
    }
    
    public func setMusicVolume(_ volume: Float) {
        self.musicVolume = volume
    }
    
    public func isOnMeowSwitch() -> Bool {
        return shouldMeow
    }
    
    public func isOnMusicSwitch() -> Bool {
        return shouldPlayMusic
    }
    
    public func musicVolumeValue() -> Float {
        return musicVolume
    }
    
    private func resetMusicPlayer() {
        guard let musicPlayer = musicPlayer, musicPlayer.isPlaying else { return }
        
        musicPlayer.stop()
        
        guard shouldPlayMusic else {
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
