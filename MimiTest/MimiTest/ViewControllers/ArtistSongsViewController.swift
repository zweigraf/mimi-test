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
    init(user: User, fetcher: APIFetching, imageLoader: ImageLoader) {
        self.fetcher = fetcher
        self.user = user
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    private lazy var ui = TableViewView()
    private let fetcher: APIFetching
    private let imageLoader: ImageLoader
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

        // Configure tableView
        ui.tableView.dataSource = self
        ui.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        ui.tableView.rowHeight = UITableView.automaticDimension

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

        let identifier = TableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell ?? TableViewCell(style: .subtitle, reuseIdentifier: identifier)

        guard let track = tracks[safe: indexPath.item] else {
            fatalError("cell")
        }

        // TODO: make better with interactor

        let viewModel = TrackViewModel(track: track)
        cell.configure(with: viewModel, imageLoader: imageLoader)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        tracks.count
    }
}
