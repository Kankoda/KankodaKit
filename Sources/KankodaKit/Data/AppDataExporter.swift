//
//  AppDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUI
import SwiftUIKit

/**
 This protocol can be implemented by types that can export a
 type that implements ``AppData``.
 */
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
        scale: CGFloat = 1
    ) async throws -> ImageRepresentable? {
        guard
            let str = try? await generateQrCodeDataString(for: data),
            let image = ImageRepresentable(scanCode: str, type: .qr, scale: scale)
        else { return nil }
        return image
    }
}
#endif
