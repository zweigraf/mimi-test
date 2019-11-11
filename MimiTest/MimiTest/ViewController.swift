//
//  ViewController.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 06.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

class ViewController: UIViewController {
    private lazy var ui = ViewControllerView()

    private var songs: [Song] = [] {
        didSet {
            ui.tableView.reloadData()
        }
    }
    override func loadView() {
        view = ui
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = "Top Songs"

        ui.tableView.dataSource = self

        let dataFetcher = URLSessionFetcher()
        let fetcher = APIFetcher(dataFetcher: dataFetcher)
        fetcher.fetchTopSongs { result in
            guard case .success(let songs) = result else { return }
            DispatchQueue.main.async {
                self.songs = songs
            }
            print(songs)
        }
    }
}

extension ViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = "Cell"
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) ?? UITableViewCell(style: .subtitle, reuseIdentifier: identifier)

        guard let song = songs[safe: indexPath.item] else {
            fatalError("cell")
        }

        cell.textLabel?.text = song.title
        cell.detailTextLabel?.text = song.user.username

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        1
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        songs.count
    }
}

private class ViewControllerView: UIView {
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)
        NSLayoutConstraint.activate(
            [tableView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
             tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
             tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
             tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 1)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("No storyboards here")
    }
}
