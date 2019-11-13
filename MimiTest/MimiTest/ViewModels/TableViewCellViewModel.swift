//
//  TableViewCellViewModel.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

protocol TableViewCellViewModel {
    var title: AnyPublisher<String?, Never> { get }
    var subtitle: AnyPublisher<String?, Never> { get }
    var imageUrl: URL? { get }
}
