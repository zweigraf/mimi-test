//
//  APIFetching.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

protocol APIFetching {
    func fetchTopSongs(completion: @escaping (Result<[Song], Error>) -> Void)
}
