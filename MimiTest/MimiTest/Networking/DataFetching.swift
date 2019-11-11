//
//  DataFetching.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

protocol DataFetching {
    func fetchData(
        for urlType: URLType,
        completion: @escaping (Result<Data, Error>) -> Void)
}

extension DataFetching {
    func fetchAndDecode<Type>(for urlType: URLType, completion: @escaping (Result<Type, Error>) -> Void) where Type : Decodable {
        fetchData(for: urlType) { result in
            let newResult = result.throwingMap { data -> Type in
                let decoder = JSONDecoder()
                let decoded = try decoder.decode(Type.self,
                                               from: data)
                return decoded
            }
            completion(newResult)
        }
    }
}
