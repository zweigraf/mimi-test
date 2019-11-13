//
//  APIFetching.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

protocol APIFetching {
    func fetchTopSongs(completion: @escaping (Result<[Song], Error>) -> Void)
    func fetchSongs(for artist: ShortArtist, completion: @escaping (Result<[Song], Error>) -> Void)
    func fetchFullArtist(for artist: ShortArtist, completion: @escaping (Result<FullArtist, Error>) -> Void)
}

extension APIFetching {
    func fetchTopArtistMapping(completion: @escaping (Result<[UserWithTracks], Error>) -> Void) {
        fetchTopSongs { result in
            let sortedMappingsResult = result.map { map(songs: $0) }
            completion(sortedMappingsResult)
        }
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
