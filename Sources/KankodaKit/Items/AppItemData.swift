//
//  AppItemData.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-29.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import CoreTransferable

/**
 This protocol can be implemented by exportable data types.
 */
public protocol AppItemData: Codable, Transferable {
    
    /// Create item data from raw `Data`.
    init(from data: Data) throws
    
    /// The name of the export data.
    var name: String { get }
    
    /// Convert the export data to raw data.
    func toData() throws -> Data
}

public extension AppItemData {
    
    /// Create item data from raw `Data` at a certain `URL`.
    init(contentsOf url: URL) throws {
        let data = try Data(contentsOf: url)
        try self.init(from: data)
    }
}
