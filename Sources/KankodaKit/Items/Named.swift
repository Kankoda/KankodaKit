//
//  Named.swift
//  WallyKit
//
//  Created by Daniel Saidi on 2022-09-15.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types with name.
 */
public protocol Named {

    /// The item name.
    var name: String { get set }
}

public extension Named {

    /// Whether or not the value has a name.
    var hasName: Bool {
        !name.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
    }

    /// Get the name of the value, with a fallback if empty.
    func name(fallback: String) -> String {
        hasName ? name : fallback
    }
}
