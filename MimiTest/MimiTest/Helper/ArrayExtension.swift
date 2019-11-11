//
//  ArrayExtension.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

extension Array {
    public subscript(safe index: Index) -> Element? {
        guard index < count else { return nil }
        return self[index]
    }
}
