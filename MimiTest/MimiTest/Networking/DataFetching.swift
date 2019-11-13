//
//  DataFetching.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

protocol DataFetching {
    func fetchData(
        for urlType: URLType) -> AnyPublisher<Data, Error>
}

extension DataFetching {
    func fetchAndDecode<Type>(for urlType: URLType) -> AnyPublisher<Type, Error> where Type : Decodable {
        fetchData(for: urlType).tryMap {
            let decoder = JSONDecoder()
            decoder.keyDecodingStrategy = .convertFromSnakeCase
            return try decoder.decode(Type.self,
                                      from: $0)
        }
        .eraseToAnyPublisher()
    }
}
