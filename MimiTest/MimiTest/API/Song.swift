//
//  Song.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

struct Song: Identifiable, Codable {
    struct User: Identifiable, Codable {
        let id: String
        let username: String
        let avatar_url: String
    }
    let id: String
    let user: User
    let title: String
    let artwork_url: String
}
