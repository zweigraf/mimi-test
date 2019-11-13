//
//  PlayerService.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import AVFoundation

class PlayerService {
    var player = AVPlayer()
    var song: Song?

    func configure(with song: Song) {
        guard let url = URL(string: song.streamUrl) else { return }
        self.song = song
        let playerItem = AVPlayerItem(url: url)
        player.replaceCurrentItem(with: playerItem)
        player.play()
    }
}
