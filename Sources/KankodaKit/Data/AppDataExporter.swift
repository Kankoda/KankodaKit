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
    
    associatedtype DataType: AppData

    func generateExportFile(for data: DataType) async throws -> URL
    func generateQrCodeDataString(for data: DataType) async throws -> String
}

public extension AppDataExporter {
    
    func generateQrCode(
        for data: DataType,
        with generator: ScanCodeGenerator
    ) async throws -> ImageRepresentable? {
        guard
            let dataString = try? await generateQrCodeDataString(for: data),
            let image = generator.generateScanCode(ofType: .qr, from: dataString)
        else { return nil }
        return image
    }
}
