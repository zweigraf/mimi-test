//
//  URLSessionFetcher.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

struct URLSessionFetcher: DataFetching {
    private let session = URLSession.shared

    func fetchData(for urlType: URLType, completion: @escaping (Result<Data, Error>) -> Void) {
        let request = session.dataTask(with: urlType.url) { data, response, error in
            guard let data = data else {
                let error = error ?? NSError(domain: "com.zweigraf.MimiTest", code: 0, userInfo: nil)
                completion(.failure(error))
                return
            }
            completion(.success(data))
        }
        request.resume()
    }
}
