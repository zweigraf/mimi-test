//
//  TableViewCell.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

class TableViewCell: UITableViewCell {
    static let reuseIdentifier = "TableViewCell"

    // MARK: Boilerplate
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: style, reuseIdentifier: reuseIdentifier)
        setupSubviews()
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        titleLabel.text = nil
        subtitleLabel.text = nil
        detailImageView.image = nil
        lastLoader?.cancelSetImage(for: detailImageView)
    }

    // MARK: Subviews

    private let titleLabel = UILabel()
    private let subtitleLabel: UILabel = {
        let label = UILabel()

        return label
    }()
    private let detailImageView = UIImageView()

    func setupSubviews() {
        detailImageView.clipsToBounds = true

        addSubview(titleLabel)
        addSubview(subtitleLabel)
        addSubview(detailImageView)

        titleLabel.translatesAutoresizingMaskIntoConstraints = false
        titleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.setContentHuggingPriority(.required, for: .vertical)
        detailImageView.translatesAutoresizingMaskIntoConstraints = false

        NSLayoutConstraint.activate([
            detailImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            detailImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            detailImageView.widthAnchor.constraint(equalTo: detailImageView.heightAnchor),
            detailImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),

            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: detailImageView.trailingAnchor, multiplier: 1),
            titleLabel.topAnchor.constraint(equalToSystemSpacingBelow: safeAreaLayoutGuide.topAnchor, multiplier: 1),
            titleLabel.trailingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.trailingAnchor, multiplier: 1),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalToSystemSpacingBelow: titleLabel.bottomAnchor, multiplier: 1),
            subtitleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -8)
        ])
    }

    // MARK: Custom Configuration

    /// ImageLoader used for loading and cancelling setting image from url.
    private var lastLoader: ImageLoader?
    func configure(with viewModel: TableViewCellViewModel,
                   imageLoader: ImageLoader? = nil) {
        titleLabel.text = viewModel.title
        subtitleLabel.text = viewModel.subtitle
        detailImageView.image = nil

        // Load and set url if needed
        lastLoader = imageLoader

        guard let loader = imageLoader,
            let url = viewModel.imageUrl else { return }
        loader.setImage(for: detailImageView, from: url)
    }
}
