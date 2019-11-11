//
//  ArtistSongsViewController.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

class ArtistSongsViewController: UIViewController {
    // MARK: Init
    init(user: User, fetcher: APIFetching) {
        self.fetcher = fetcher
        self.user = user
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    private lazy var ui = TableViewView()
    private let fetcher: APIFetching
    private let user: User

    private var tracks: [Song] = [] {
        didSet {
            ui.tableView.reloadData()
        }
    }

    // MARK: UIViewController Overrides
    override func loadView() {
        view = ui
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = user.username

        ui.tableView.dataSource = self

        fetcher.fetchSongs(for: user) { result in
            // TODO: show error
            guard case .success(let value) = result else { return }
            DispatchQueue.main.async {
                self.tracks = value
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension ArtistSongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: identifier)

        guard let track = tracks[safe: indexPath.item] else {
            fatalError("cell")
        }

        cell.textLabel?.text = track.title
//        cell.detailTextLabel?.text = "\(mapping.tracks.count) Tracks"

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
}
