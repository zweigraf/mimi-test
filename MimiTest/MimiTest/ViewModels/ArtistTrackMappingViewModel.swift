//
//  ArtistTrackMappingViewModel.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

struct ArtistTrackMappingViewModel {
    let artistMapping: UserWithTracks
    let apiFetcher: APIFetching
}

// MARK: - TableViewCellViewModel
extension ArtistTrackMappingViewModel: TableViewCellViewModel {
    var title: AnyPublisher<String?, Never> {
        Just(artistMapping.user.username)
            .eraseToAnyPublisher()
    }

    var subtitle: AnyPublisher<String?, Never> {
        // This does not work nicely with localization. For proper
        // localization, this logic should be encoded for different languages.
        let count = artistMapping.tracks.count
        let returnValue: String
        if count == 1 {
            returnValue = "1 Track"
        } else {
            returnValue = "\(count) Tracks"
        }
        return Just(returnValue)
            .eraseToAnyPublisher()
    }

    var imageUrl: URL? {
        return URL(string: artistMapping.user.avatarUrl)
    }
}
