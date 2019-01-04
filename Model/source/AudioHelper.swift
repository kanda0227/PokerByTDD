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
        
        guard let path = Bundle.main.path(forResource: audio.rawValue, ofType: MusicAudio.type()) else {
            fatalError("音楽リソースを用意しておくれ")
        }
        
        musicPlayer = try! AVAudioPlayer(contentsOf: URL(fileURLWithPath: path))
        
        musicPlayer?.delegate = self
        musicPlayer?.numberOfLoops = -1
        musicPlayer?.play()
    }
    
    public func setIsOnMeowSwitch(_ shouldSound: Bool) {
        self.shouldMeow = shouldSound
    }
    
    public func isOnMeowSwitch() -> Bool {
        return shouldMeow
    }
}

public enum NekoAudio: String {
    case meow
    
    fileprivate static func type() -> String? {
        return "mp3"
    }
}

public enum MusicAudio: String {
    case undefault
    
    fileprivate static func type() -> String? {
        return "mp3"
    }
}
