//
//  PlayerViewController.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 13.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import AVKit

class PlayerViewController: UIViewController {
    private let ui = PlayerViewControllerView()
    private let playerService: PlayerService

    init(playerService: PlayerService) {
        self.playerService = playerService
        super.init(nibName: nil, bundle: nil)
    }

    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func loadView() {
        view = ui
    }

    override func viewDidLoad() {
        super.viewDidLoad()

        guard let song = playerService.song else { return }
        title = song.title
        ui.titleLabel.text = song.title
        ui.artistLabel.text = song.user.username
    }
}

private class PlayerViewControllerView: UIView {
    let titleLabel = UILabel()
    let artistLabel = UILabel()

    override init(frame: CGRect) {
        super.init(frame: frame)

        backgroundColor = .systemBlue
        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        artistLabel.translatesAutoresizingMaskIntoConstraints = false

        titleLabel.numberOfLines = 0
        artistLabel.numberOfLines = 0

        artistLabel.textColor = .secondaryLabel

        addSubview(titleLabel)
        addSubview(artistLabel)
        NSLayoutConstraint.activate([
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1),
            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            titleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.trailingAnchor, multiplier: -1),
            artistLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            artistLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            artistLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("No storyboards here")
    }
}
