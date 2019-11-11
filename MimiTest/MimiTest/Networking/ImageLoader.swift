//
//  ImageLoader.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

class ImageLoader {
    let fetcher: DataFetching
    var map = [UIImageView: URL]()

    init(fetcher: DataFetching) {
        self.fetcher = fetcher
    }

    private func image(from url: URL, completion: @escaping (Result<UIImage, Error>) -> Void) {
        fetcher.fetchData(for: url) { result in
            let newResult = result.throwingMap { data -> UIImage in
                guard let image = UIImage(data: data) else {
                    throw NSError(domain: "com.zweigraf.MimiTest", code: 1, userInfo: nil)
                }
                return image
            }
            completion(newResult)
        }
    }
}

extension ImageLoader {
    func setImage(for view: UIImageView, from url: URL) {
        map[view] = url
        image(from: url) { result in
            // Dispatch setting of image to main queue, as we can only
            // modify UI components on main thread
            DispatchQueue.main.async {
                // In case the request got cancelled, or something else wanted
                // to set an image on this view, do nothing.
                guard case .success(let image) = result,
                    self.map[view] == url else { return }

                view.image = image
                view.sizeToFit()

                // Clear out the map for the next request
                self.map[view] = nil
            }
        }
    }

    func cancelSetImage(for view: UIImageView) {
        map[view] = nil
    }
}
