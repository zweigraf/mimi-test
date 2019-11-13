//
//  ShortArtist.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

struct ShortArtist: Identifiable, Codable, Equatable, Hashable {
    let id: String
    let username: String
    let avatarUrl: String
    let permalink: String
}
