//
//  TrackViewModel.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

struct TrackViewModel {
    let track: Song

    private let durationFormatter: DateComponentsFormatter = {
        let formatter = DateComponentsFormatter()
        formatter.unitsStyle = .positional
        formatter.allowedUnits = [.hour, .minute, .second]
        formatter.zeroFormattingBehavior = .default
        return formatter
    }()
}

// MARK: - TableViewCellViewModel
extension TrackViewModel: TableViewCellViewModel {
    var title: AnyPublisher<String?, Never> {
        return Just(track.title)
            .eraseToAnyPublisher()
    }

    var subtitle: AnyPublisher<String?, Never> {
        let duration = track.durationInterval
        let durationString = durationFormatter.string(from: duration)
        return Just("Duration: \(durationString ?? "0:00:00")")
            .eraseToAnyPublisher()
    }

    var imageUrl: URL? {
        return URL(string: track.artworkUrl)
    }
}
