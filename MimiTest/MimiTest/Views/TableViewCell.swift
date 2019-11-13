//
//  TableViewCell.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
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
        // Cancel all cancellables
        disposeBag = Set<AnyCancellable>()
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
        titleLabel.adjustsFontSizeToFitWidth = true
        subtitleLabel.translatesAutoresizingMaskIntoConstraints = false
        subtitleLabel.setContentHuggingPriority(.required, for: .vertical)
        subtitleLabel.adjustsFontSizeToFitWidth = true
        detailImageView.translatesAutoresizingMaskIntoConstraints = false

        let defaultMargin: CGFloat = 8.0
        NSLayoutConstraint.activate([
            detailImageView.leadingAnchor.constraint(equalToSystemSpacingAfter: safeAreaLayoutGuide.leadingAnchor, multiplier: 1),
            detailImageView.heightAnchor.constraint(equalTo: safeAreaLayoutGuide.heightAnchor),
            detailImageView.widthAnchor.constraint(equalTo: detailImageView.heightAnchor),
            detailImageView.centerYAnchor.constraint(equalTo: safeAreaLayoutGuide.centerYAnchor),
            detailImageView.heightAnchor.constraint(greaterThanOrEqualToConstant: 54),

            titleLabel.leadingAnchor.constraint(equalToSystemSpacingAfter: detailImageView.trailingAnchor, multiplier: 1),
            titleLabel.topAnchor.constraint(equalTo: safeAreaLayoutGuide.topAnchor, constant: defaultMargin),
            titleLabel.trailingAnchor.constraint(equalTo: safeAreaLayoutGuide.trailingAnchor, constant: -1 * defaultMargin),

            subtitleLabel.leadingAnchor.constraint(equalTo: titleLabel.leadingAnchor),
            subtitleLabel.trailingAnchor.constraint(equalTo: titleLabel.trailingAnchor),
            subtitleLabel.topAnchor.constraint(equalTo: titleLabel.bottomAnchor, constant: defaultMargin / 2),
            subtitleLabel.bottomAnchor.constraint(equalTo: safeAreaLayoutGuide.bottomAnchor, constant: -1 * defaultMargin)
        ])
    }

    // MARK: Custom Configuration

    /// ImageLoader used for loading and cancelling setting image from url.
    private var lastLoader: ImageLoader?
    private var disposeBag = Set<AnyCancellable>()

    func configure(with viewModel: TableViewCellViewModel,
                   imageLoader: ImageLoader? = nil) {
        viewModel.title
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.titleLabel)
            .store(in: &disposeBag)
        viewModel.subtitle
            .receive(on: DispatchQueue.main)
            .assign(to: \.text, on: self.subtitleLabel)
            .store(in: &disposeBag)
        detailImageView.image = nil

        // Load and set url if needed
        lastLoader = imageLoader

        guard let loader = imageLoader,
            let url = viewModel.imageUrl else { return }
        loader.setImage(for: detailImageView, from: url)
    }
}
