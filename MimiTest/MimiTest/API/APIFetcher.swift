//
//  APIFetcher.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

struct APIFetcher: APIFetching {
    let dataFetcher: DataFetching

    func fetchTopSongs() -> AnyPublisher<[Song], Error> {
        dataFetcher.fetchAndDecode(for: Endpoint.topSongs)
    }

    func fetchSongs(for artist: ShortArtist) -> AnyPublisher<[Song], Error> {
        dataFetcher.fetchAndDecode(for: Endpoint.artistSongs(artist))
    }

    func fetchFullArtist(for artist: ShortArtist) -> AnyPublisher<FullArtist, Error> {
        dataFetcher.fetchAndDecode(for: Endpoint.artistInfo(artist))
    }
}
