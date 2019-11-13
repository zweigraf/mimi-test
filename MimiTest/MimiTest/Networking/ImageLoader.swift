//
//  ImageLoader.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Combine
import UIKit

class ImageLoader {
    let fetcher: DataFetching

    init(fetcher: DataFetching) {
        self.fetcher = fetcher
    }

    func image(from url: URL) -> AnyPublisher<UIImage, Error> {
        fetcher.fetchData(for: url).tryMap { data in
            guard let image = UIImage(data: data) else {
                throw NSError(domain: "com.zweigraf.MimiTest", code: 1, userInfo: nil)
            }
            return image
        }.eraseToAnyPublisher()
    }
}
