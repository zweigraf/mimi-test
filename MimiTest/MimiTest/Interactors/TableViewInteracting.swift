//
//  TableViewInteracting.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

protocol TableViewInteracting: class {
    // General ViewController data
    var title: String { get }
    func viewDidLoad()

    // TableView Data Source
    func numberOfSections() -> Int
    func tableView(numberOfRowsInSection section: Int) -> Int
    func tableView(viewModelForRowAt indexPath: IndexPath) -> TableViewCellViewModel

    // TableView Delegate
    func tableView(didSelectRowAt indexPath: IndexPath)
}

protocol TableViewInteractingDelegate: class {
    /// Called when underlying data is updated. Can be called from any thread.
    /// Always dispatch to Main queue if you are doing anything UI related.
    func didUpdateData()
    /// Called when an error is encountered and should be shown. Can be called
    /// from any thread. Always dispatch to Main queue if you are doing anything UI related.
    func didEncounterError(error: Error)
}
