//
//  Routing.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import UIKit

protocol Routing {
    func presentTopArtists(on window: UIWindow)
    func presentSongs(for artist: ShortArtist, on viewController: UIViewController)
    func presentErrorAlert(for error: Error, on viewController: UIViewController)
    func presentPlayer(for song: Song, on viewController: UIViewController)
}
