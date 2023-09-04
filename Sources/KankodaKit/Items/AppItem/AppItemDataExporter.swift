//
//  AppItemDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-03.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by classes that can export
 ``AppItemData`` to export files.
 
 `TODO` Replace this with ``AppDataExporter``.
 */
public protocol AppItemDataExporter {
    
    /// Generate an export file for the provided data.
    func generateExportFile(
        for data: any AppItemData
    ) async throws -> URL
}
