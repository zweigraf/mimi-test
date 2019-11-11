//
//  Router.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

protocol Routing {
    func presentSongs(for artist: User, fetcher: APIFetching, on viewController: UIViewController)
}

struct Router: Routing {
    func presentSongs(for artist: User, fetcher: APIFetching, on viewController: UIViewController) {
        let songsViewController = ArtistSongsViewController(user: artist, fetcher: fetcher)
        viewController.navigationController?.pushViewController(songsViewController, animated: true)
    }
}
