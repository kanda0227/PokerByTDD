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
