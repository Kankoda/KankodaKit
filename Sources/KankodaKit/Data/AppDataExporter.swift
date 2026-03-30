//
//  AppDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import ScanCodes
import SwiftUI

/// This protocol can be implemented by any type that can export ``AppData``.
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

#if os(macOS) || os(iOS) || os(tvOS)
public extension AppDataExporter {
    
    func generateQrCode<DataType: AppData>(
        for data: DataType,
        scale: CGFloat = 5
    ) async throws -> ImageRepresentable? {
        guard let str = try? await generateQrCodeDataString(for: data) else { return nil }
        return ImageRepresentable(
            scanCode: str,
            type: ScanCodes.ScanCodeType.qr,
            scale: scale
        )
    }
}
#endif
