//
//  UserWithTracks.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

struct UserWithTracks: Comparable, Equatable {
    let user: User
    var tracks: [Song]

    static func < (lhs: UserWithTracks, rhs: UserWithTracks) -> Bool {
        lhs.tracks.count < rhs.tracks.count
    }
}
