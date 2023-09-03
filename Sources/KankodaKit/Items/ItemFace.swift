//
//  ItemFace.swift
//  WallyKit
//
//  Created by Daniel Saidi on 2022-06-27.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This enum represents the faces of a physical app items.
 */
public enum ItemFace: String, CaseIterable, Identifiable {

    case front, back

    public var id: String { rawValue }
}
