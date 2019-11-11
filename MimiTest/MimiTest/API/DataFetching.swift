//
//  DataFetching.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

protocol DataFetching {
    func fetchData(for urlType: URLType, completion: @escaping (Result<Data, Error>) -> Void)
}
