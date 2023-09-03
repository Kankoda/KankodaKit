//
//  Numbered.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-17.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by numbered data types.
 */
public protocol Numbered {

    /// The item number.
    var number: String { get set }
}

public extension Numbered {

    /// Whether or not the value has a number.
    var hasNumber: Bool {
        !number.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }
}
