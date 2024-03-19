//
//  AudioPlayerService.swift
//  tip-calculator
//
//  Created by Yani Buchkov on 19.03.24.
//

import Foundation
import AVFoundation

protocol AudioPlayerService {
    func play()
}

final class DefaultAudioPlayer: AudioPlayerService {
    // MARK: - Properties
    private var player: AVAudioPlayer?
    
    // MARK: - AudioPlayerService
    func play() {
        guard let path = Bundle.main.path(forResource: "click", ofType: "m4a") else {
            print("Sound doesn't exist")
            return
        }
        let url = URL(filePath: path)
        do {
            player = try AVAudioPlayer(contentsOf: url)
            player?.play()
        } catch (let error) {
            print(error.localizedDescription)
        }
    }
}
