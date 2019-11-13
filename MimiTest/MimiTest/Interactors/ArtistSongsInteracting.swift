//
//  ArtistSongsInteracting.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

protocol ArtistSongsInteracting: TableViewInteracting {
    var delegate: ArtistSongsInteractingDelegate? { get set }
}

protocol ArtistSongsInteractingDelegate: TableViewInteractingDelegate {
    func present(song: Song)
}

class ArtistSongsInteractor: ArtistSongsInteracting {
    private let fetcher: APIFetching
    private let user: ShortArtist
    private var tracks: [Song] = []

    init(user: ShortArtist, fetcher: APIFetching) {
        self.fetcher = fetcher
        self.user = user
    }

    // MARK: ArtistSongsInteracting
    func viewDidLoad() {
        fetcher.fetchSongs(for: user) { result in
            switch result {
            case .success(let songs):
                self.tracks = songs
                self.delegate?.didUpdateData()
            case .failure(let error):
                self.delegate?.didEncounterError(error: error)
            }
        }
    }

    var title: String {
        user.username
    }

    weak var delegate: ArtistSongsInteractingDelegate?

    // MARK: TableView Data Source
    func numberOfSections() -> Int {
        1
    }

    func tableView(numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }

    func tableView(viewModelForRowAt indexPath: IndexPath) -> TableViewCellViewModel {
        guard let track = tracks[safe: indexPath.item] else {
            // We should have better error handling here
            fatalError("Request for non existing track")
        }
        return TrackViewModel(track: track)
    }

    // MARK: TableView Delegate
    func tableView(didSelectRowAt indexPath: IndexPath) {
        guard let track = tracks[safe: indexPath.item] else {
            // We should have better error handling here
            fatalError("Request for non existing track")
        }

        delegate?.present(song: track)
    }
}
