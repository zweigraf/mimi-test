//
//  Song.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

struct Song: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let user: ShortArtist
    let title: String
    let artworkUrl: String
    let streamUrl: String
    private let duration: String
}

extension Song {
    var durationInterval: TimeInterval {
        return TimeInterval(duration) ?? 0
    }
}
