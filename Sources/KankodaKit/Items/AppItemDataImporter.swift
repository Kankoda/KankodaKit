//
//  AppItemDataImporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-03.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can import
 ``AppItemData`` values.
 */
public protocol AppItemDataImporter {
    
    /// Try to import item data from a certain url.
    func importData(from url: URL) async throws
}
