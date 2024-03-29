//
//  APIFetching.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

protocol APIFetching {
    func fetchTopSongs() -> AnyPublisher<[Song], Error>
    func fetchSongs(for artist: ShortArtist) -> AnyPublisher<[Song], Error>
    func fetchFullArtist(for artist: ShortArtist) -> AnyPublisher<FullArtist, Error>
}

extension APIFetching {
    func fetchTopArtistMapping() -> AnyPublisher<[UserWithTracks], Error> {
        fetchTopSongs()
            .map { map(songs: $0) }
            .eraseToAnyPublisher()
    }
}

private func map(songs: [Song]) -> [UserWithTracks] {
    let reducedSongs = songs.reduce([ShortArtist: [Song]]()) { aggr, song in
        var aggrCopy = aggr
        var songs = aggrCopy[song.user] ?? []
        songs.append(song)
        aggrCopy[song.user] = songs
        return aggrCopy
    }

    let mappings = reducedSongs.map {
        UserWithTracks(user: $0.key, tracks: $0.value)
    }

    return mappings.sorted().reversed()
}
