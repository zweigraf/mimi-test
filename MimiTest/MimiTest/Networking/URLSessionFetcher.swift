//
//  URLSessionFetcher.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import Foundation

struct URLSessionFetcher: DataFetching {
    private let session = URLSession.shared

    func fetchData(for urlType: URLType) -> AnyPublisher<Data, Error> {
        // Error needs to be mapped here to hide the type (URLError)
        session
            .dataTaskPublisher(for: urlType.url)
            .map { $0.data }
            .mapError { $0 }
            .eraseToAnyPublisher()
    }
}
