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
    init(interactor: TopArtistsInteracting, router: Routing, imageLoader: ImageLoader) {
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
    private let interactor: TopArtistsInteracting
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

        // Configure tableview
        ui.tableView.dataSource = self
        ui.tableView.delegate = self
        ui.tableView.rowHeight = UITableView.automaticDimension
    
        ui.tableView.register(TableViewCell.self, forCellReuseIdentifier: TableViewCell.reuseIdentifier)
    }
}

// MARK: - UITableViewDataSource
extension TopArtistsViewController: UITableViewDataSource {
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

// MARK: - UITableViewDelegate
extension TopArtistsViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        interactor.tableView(didSelectRowAt: indexPath)
    }
}

// MARK: - TableViewInteractingDelegate
extension TopArtistsViewController: TopArtistsInteractingDelegate {
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

    func presentSongs(for artist: ShortArtist) {
        router.presentSongs(for: artist, on: self)
    }
}
