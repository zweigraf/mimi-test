//
//  TableViewView.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

class TableViewView: UIView {
    let tableView = UITableView()

    override init(frame: CGRect) {
        super.init(frame: frame)

        tableView.translatesAutoresizingMaskIntoConstraints = false

        addSubview(tableView)
        NSLayoutConstraint.activate([
            tableView.topAnchor.constraint(equalToSystemSpacingBelow: topAnchor, multiplier: 1),
            tableView.leadingAnchor.constraint(equalTo: leadingAnchor),
            tableView.trailingAnchor.constraint(equalTo: trailingAnchor),
            tableView.bottomAnchor.constraint(equalToSystemSpacingBelow: bottomAnchor, multiplier: 1)
        ])
    }

    required init?(coder: NSCoder) {
        fatalError("No storyboards here")
    }
}

