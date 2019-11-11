//
//  TopArtistsViewController.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 06.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

class TopArtistsViewController: UIViewController {
    // MARK: Init
    init(fetcher: APIFetching, router: Routing, imageLoader: ImageLoader) {
        self.fetcher = fetcher
        self.router = router
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    private lazy var ui = TableViewView()
    private let fetcher: APIFetching
    private let router: Routing
    private let imageLoader: ImageLoader

    private var userWithTracks: [UserWithTracks] = [] {
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
        title = "Top Artists"

        // Configure tableview
        ui.tableView.dataSource = self
        ui.tableView.delegate = self
        ui.tableView.rowHeight = UITableView.automaticDimension
    
        // TODO: dedup identifier
        ui.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)

        fetcher.fetchTopArtistMapping { result in
            guard case .success(let value) = result else {
                // TODO: error handling
                return
            }
            DispatchQueue.main.async {
                self.userWithTracks = value
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TopArtistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = TableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell ?? TableViewCell(style: .subtitle, reuseIdentifier: identifier)


        // TODO: bla
        guard let mapping = userWithTracks[safe: indexPath.item] else {
            fatalError("cell")
        }

        let viewModel = ArtistTrackMappingViewModel(artistMapping: mapping)
        cell.configure(with: viewModel, imageLoader: imageLoader)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        userWithTracks.count
    }
}

// MARK: - UITableViewDelegate
extension TopArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // TODO: bla
        guard let mapping = userWithTracks[safe: indexPath.item] else {
            fatalError("cell")
        }

        let user = mapping.user
        router.presentSongs(for: user, on: self)
    }
}
