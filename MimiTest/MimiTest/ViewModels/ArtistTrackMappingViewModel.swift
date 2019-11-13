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
        apiFetcher.fetchFullArtist(for: artistMapping.user)
            .map { format(trackCount: $0.trackCount) }
            .catch { _ in Just(nil) }
            .eraseToAnyPublisher()
    }

    var imageUrl: URL? {
        return URL(string: artistMapping.user.avatarUrl)
    }
}

private func format(trackCount: Int) -> String {
    // This does not work nicely with localization. For proper
    // localization, this logic should be encoded for different languages.
    if trackCount == 1 {
        return "1 Track"
    } else {
        return "\(trackCount) Tracks"
    }
}
