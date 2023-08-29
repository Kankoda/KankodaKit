//
//  AppItemExportData.swift
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
public protocol AppItemExportData: Codable, Transferable {
    
    /// The name of the export data.
    var name: String { get }
    
    /// Convert the export data to raw data.
    func toData() throws -> Data
}
