//
//  TopArtistsInteracting.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

protocol TopArtistsInteracting: TableViewInteracting {
    var delegate: TopArtistsInteractingDelegate? { get set }
}

protocol TopArtistsInteractingDelegate: TableViewInteractingDelegate {
    func presentSongs(for artist: ShortArtist)
}

class TopArtistsInteractor: TopArtistsInteracting {
    // MARK: Configuration
    private let fetcher: APIFetching
    private var userWithTracks: [UserWithTracks] = []
    private var disposeBag = Set<AnyCancellable>()

    init(fetcher: APIFetching) {
        self.fetcher = fetcher
    }

    // MARK: TableViewInteracting
    weak var delegate: TopArtistsInteractingDelegate?

    var title: String {
        "Top Artists"
    }

    func viewDidLoad() {
        fetcher.fetchTopArtistMapping()
            .sink(receiveCompletion: { completion in
                if case .failure(let error) = completion {
                    self.delegate?.didEncounterError(error: error)
                }
            }, receiveValue: { mappings in
                self.userWithTracks = mappings
                self.delegate?.didUpdateData()
            })
            .store(in: &disposeBag)
    }

    // MARK: TableView Data Source
    func numberOfSections() -> Int {
        1
    }

    func tableView(numberOfRowsInSection section: Int) -> Int {
        userWithTracks.count
    }

    func tableView(viewModelForRowAt indexPath: IndexPath) -> TableViewCellViewModel {
        guard let mapping = userWithTracks[safe: indexPath.item] else {
            // We should have better error handling here
            fatalError("Request for non existing mapping")
        }
        return ArtistTrackMappingViewModel(artistMapping: mapping,
                                           apiFetcher: fetcher)
    }

    // MARK: TableView Delegate
    func tableView(didSelectRowAt indexPath: IndexPath) {
        guard let mapping = userWithTracks[safe: indexPath.item] else {
            // We should have better error handling here
            fatalError("Request for non existing mapping")
        }
        delegate?.presentSongs(for: mapping.user)
    }
}
