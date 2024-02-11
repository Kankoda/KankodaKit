//
//  AppDataExportable.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

import Foundation
import CoreTransferable

/**
 This protocol can be implemented by exportable data types.
 */
public protocol AppDataExportable {

    /// Generate exportable data.
    func exportData() -> any AppData
}
