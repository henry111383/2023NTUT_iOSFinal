//
//  AudioPlayer.swift
//  iOS_2023final
//
//  Created by Jing Han on 2023/6/19.
//

import Foundation
import AVKit

class AudioPlayer {
    var player: AVPlayer?
    var playerItem: AVPlayerItem?
    let MyURL: URL = Bundle.main.url(forResource: "HereItComes", withExtension: "mp3")!
    
    func playAudio() {
        print(MyURL)
        playerItem = AVPlayerItem(url: MyURL)
        player = AVPlayer(playerItem: playerItem)
        
        // 監聽播放完成通知
        NotificationCenter.default.addObserver(self, selector: #selector(playerItemDidReachEnd), name: .AVPlayerItemDidPlayToEndTime, object: playerItem)
        
        player?.play()
    }
    
    @objc func playerItemDidReachEnd(notification: NSNotification) {
        // 播放完成時重新播放
        player?.seek(to: .zero)
        player?.play()
    }
    
    func pauseAudio() {
        player?.pause()
    }
    
    func stopAudio() {
        player?.pause()
        player?.seek(to: .zero)
    }
}
