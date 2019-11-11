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
    init(interactor: ArtistSongsInteracting, router: Routing, imageLoader: ImageLoader) {
        self.interactor = interactor
        self.router = router
        self.imageLoader = imageLoader
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    // MARK: Properties
    private lazy var ui = TableViewView()
    private let interactor: ArtistSongsInteracting
    private let router: Routing
    private let imageLoader: ImageLoader

    // MARK: UIViewController Overrides
    override func loadView() {
        view = ui
    }

    override func viewDidLoad() {
        super.viewDidLoad()
        title = interactor.title

        interactor.delegate = self
        interactor.viewDidLoad()

        // Configure tableView
        ui.tableView.dataSource = self
        ui.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
        ui.tableView.rowHeight = UITableView.automaticDimension
    }
}

// MARK: - UITableViewDataSource
extension ArtistSongsViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let identifier = TableViewCell.reuseIdentifier
        let cell = tableView.dequeueReusableCell(withIdentifier: identifier) as? TableViewCell ?? TableViewCell(style: .subtitle, reuseIdentifier: identifier)

        let viewModel = interactor.tableView(viewModelForRowAt: indexPath)
        cell.configure(with: viewModel, imageLoader: imageLoader)

        return cell
    }

    func numberOfSections(in tableView: UITableView) -> Int {
        interactor.numberOfSections()
    }

    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        interactor.tableView(numberOfRowsInSection: section)
    }
}

// MARK: - TableViewInteractingDelegate
extension ArtistSongsViewController: ArtistSongsInteractingDelegate {
    func didUpdateData() {
        DispatchQueue.main.async {
            self.ui.tableView.reloadData()
        }
    }

    func didEncounterError(error: Error) {
        DispatchQueue.main.async {
            self.router.presentErrorAlert(for: error, on: self)
        }
    }

    func present(song: Song) {
//        router.prese
    }
}
