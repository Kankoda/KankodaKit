//
//  AppDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This protocol can be implemented by any type that can be
/// used to export a ``AppData`` types.
public protocol AppDataExporter {
    
    func generateExportFile<DataType: AppData>(
        for data: DataType
    ) async throws -> URL
    
    func generateQrCodeDataString<DataType: AppData>(
        for data: DataType
    ) async throws -> String
}

#if os(macOS) || os(iOS) || os(tvOS)
public extension AppDataExporter {
    
    func generateQrCode<DataType: AppData>(
        for data: DataType,
        scale: CGFloat = 5
    ) async throws -> ImageRepresentable? {
        guard
            let str = try? await generateQrCodeDataString(for: data),
            let image = ImageRepresentable(scanCode: str, type: .qr, scale: scale)
        else { return nil }
        return image
    }
}
#endif
