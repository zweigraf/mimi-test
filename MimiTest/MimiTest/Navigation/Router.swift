//
//  Router.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit
import AVKit

struct Router: Routing {
    /// API Fetcher used for passing into components that need it.
    let fetcher: APIFetching
    let imageLoader: ImageLoader
    let playerService: PlayerService

    func presentSongs(for artist: ShortArtist, on viewController: UIViewController) {
        let interactor = ArtistSongsInteractor(user: artist, fetcher: fetcher)
        let songsViewController = ArtistSongsViewController(interactor: interactor,
                                                            router: self,
                                                            imageLoader: imageLoader)
        viewController.navigationController?.pushViewController(songsViewController, animated: true)
    }

    func presentTopArtists(on window: UIWindow) {
        let interactor = TopArtistsInteractor(fetcher: fetcher)
        let mainViewController = TopArtistsViewController(interactor: interactor,
                                                          router: self,
                                                          imageLoader: imageLoader)
        let navigationController = UINavigationController(rootViewController: mainViewController)
        window.rootViewController = navigationController
    }

    func presentErrorAlert(for error: Error, on viewController: UIViewController) {
        let controller = UIAlertController(title: "Oops",
                                           message: error.localizedDescription,
                                           preferredStyle: .alert)
        controller.addAction(UIAlertAction(title: "Okay", style: .default, handler: { _ in
            controller.dismiss(animated: true)
        }))
        viewController.present(controller, animated: true)
    }

    func presentPlayer(for song: Song, on viewController: UIViewController) {
        playerService.configure(with: song)
        let playerController = AVPlayerViewController()
        playerController.player = playerService.player
        viewController.present(playerController, animated: true) {
            playerController.player?.play()
        }
    }
}
