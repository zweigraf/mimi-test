//
//  Router.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

struct Router: Routing {
    /// API Fetcher used for passing into components that need it.
    let fetcher: APIFetching

    func presentSongs(for artist: User, on viewController: UIViewController) {
        let songsViewController = ArtistSongsViewController(user: artist, fetcher: fetcher)
        viewController.navigationController?.pushViewController(songsViewController, animated: true)
    }

    func presentTopArtists(on window: UIWindow) {
        let mainViewController = TopArtistsViewController(fetcher: fetcher, router: self)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController
    }
}
