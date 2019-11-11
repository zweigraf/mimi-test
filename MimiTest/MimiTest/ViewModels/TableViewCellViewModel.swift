//
//  TableViewCellViewModel.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

protocol TableViewCellViewModel {
    var title: String { get }
    var subtitle: String { get }
    var imageUrl: URL? { get }
}
