//
//  FullArtist.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 13.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

struct FullArtist: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let username: String
    let avatarUrl: String
    let permalink: String
    let trackCount: Int
}
