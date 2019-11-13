//
//  APIFetcher.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

struct APIFetcher: APIFetching {
    let dataFetcher: DataFetching

    func fetchTopSongs(completion: @escaping (Result<[Song], Error>) -> Void) {
        dataFetcher.fetchAndDecode(for: Endpoint.topSongs,
                                   completion: completion)
    }

    func fetchSongs(for artist: ShortArtist, completion: @escaping (Result<[Song], Error>) -> Void) {
        dataFetcher.fetchAndDecode(for: Endpoint.artistSongs(artist),
                                   completion: completion)
    }

    func fetchFullArtist(for artist: ShortArtist, completion: @escaping (Result<FullArtist, Error>) -> Void) {
        dataFetcher.fetchAndDecode(for: Endpoint.artistInfo(artist),
                                   completion: completion)
    }
}
