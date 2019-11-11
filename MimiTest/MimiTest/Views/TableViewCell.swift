//
//  TableViewCell.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

protocol TableViewCellViewModel {
    var title: String { get }
    var subtitle: String { get }
    var imageUrl: URL? { get }
}

class TableViewCell: UITableViewCell {
    override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
        super.init(style: .subtitle, reuseIdentifier: reuseIdentifier)
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func configure(with viewModel: TableViewCellViewModel) {
        // TODO: set image from url
        textLabel?.text = viewModel.title
        detailTextLabel?.text = viewModel.subtitle
    }

    override func prepareForReuse() {
        super.prepareForReuse()
        textLabel?.text = nil
        detailTextLabel?.text = nil
        // TODO: cancel image
    }
}
