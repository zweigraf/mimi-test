//
//  Endpoint.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

enum Endpoint: URLType {
    case topSongs
    case artistSongs(User)

    var url: URL {
        guard let url = URL(string: urlString) else {
            fatalError("\(self) has no valid `urlString`.")
        }
        return url
    }

    private var urlString: String {
        switch self {
        case .topSongs:
            return "https://api-v2.hearthis.at/feed/?type=popular&page=1&count=100"
        case .artistSongs(let user):
            return "https://api-v2.hearthis.at/\(user.permalink)/?type=tracks&page=1&count=5"
        }
    }
}
