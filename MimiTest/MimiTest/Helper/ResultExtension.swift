//
//  ResultExtension.swift
//  MimiTest
//
//  Created by Luis Reisewitz on 11.11.19.
//  Copyright © 2019 ZweiGraf. All rights reserved.
//

import Foundation

extension Result where Failure == Error {
    /// Tries to transform the success value in the Result.
    /// If result contains error, just passes error.
    /// In case the transformation throws an error, returns a
    /// result with that error instead.
    /// - Parameter transform: Transformation closure.
    func throwingMap<NewSuccess>(transform: (Success) throws -> NewSuccess) -> Result<NewSuccess, Failure> {
        switch self {
        case .failure(let error):
            return .failure(error)
        case .success(let value):
            do {
                let newValue = try transform(value)
                return .success(newValue)
            } catch {
                return .failure(error)
            }
        }
    }
}
