//
//  ArtistViewModel.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

struct ArtistTrackMappingViewModel {
    let artistMapping: UserWithTracks
}

// MARK: - TableViewCellViewModel
extension ArtistTrackMappingViewModel: TableViewCellViewModel {
    var title: String {
        return artistMapping.user.username
    }

    var subtitle: String {
        // This does not work nicely with localization. For proper
        // localization, this logic should be encoded for different languages.
        let count = artistMapping.tracks.count
        if count == 1 {
            return "1 Track"
        } else {
            return "\(count) Tracks"
        }
    }

    var imageUrl: URL? {
        return URL(string: artistMapping.user.avatarUrl)
    }
}
