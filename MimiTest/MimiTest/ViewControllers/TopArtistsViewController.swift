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
    init(fetcher: APIFetching, router: Routing) {
        self.fetcher = fetcher
        self.router = router
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    private lazy var ui = TableViewView()
    private let fetcher: APIFetching
    private let router: Routing

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

        ui.tableView.dataSource = self
        ui.tableView.delegate = self

        fetcher.fetchTopArtistMapping { result in
            guard case .success(let value) = result else { return }
            DispatchQueue.main.async {
                self.userWithTracks = value
            }
        }
    }
}

// MARK: - UITableViewDataSource
extension TopArtistsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: identifier)

        guard let mapping = userWithTracks[safe: indexPath.item] else {
            fatalError("cell")
        }

        cell.textLabel?.text = mapping.user.username
        cell.detailTextLabel?.text = "\(mapping.tracks.count) Tracks"

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
        guard let mapping = userWithTracks[safe: indexPath.item] else {
            fatalError("cell")
        }

        let user = mapping.user
        router.presentSongs(for: user, fetcher: fetcher, on: self)
    }
}
