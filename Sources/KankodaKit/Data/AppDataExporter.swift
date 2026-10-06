//
//  AppDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import SwiftUI

/// This protocol can be implemented by any type that can be
/// used to export ``AppData``.
public protocol AppDataExporter {
    
    func generateExportFile<DataType: AppData>(
        for data: DataType
    ) async throws -> URL
    
    func generateQrCodeDataString<DataType: AppData>(
        for data: DataType
    ) async throws -> String
}

#if canImport(UIKit)
public typealias ImageRepresentable = UIImage
#else
public typealias ImageRepresentable = NSImage
#endif
