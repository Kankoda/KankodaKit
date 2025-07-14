//
//  StandardAppDataImporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import Foundation

/// This importer imports compressed data.
///
/// The `qrCodeUrlPrefix` is optional, and will only be used
/// by QR codes to import & export small amounts of data.
open class StandardAppDataImporter<DataType: AppData & Sendable>: AppDataImporter {

    public init(
        qrCodeUrlPrefix: String = "qr:",
        importer: @escaping (DataType) async throws -> Void
    ) {
        self.qrCodeUrlPrefix = qrCodeUrlPrefix
        self.importer = importer
    }
    
    private let qrCodeUrlPrefix: String
    private let importer: (DataType) async throws -> Void
}

public extension StandardAppDataImporter {

    func importData(from url: URL) async throws {
        if url.absoluteString.hasPrefix(qrCodeUrlPrefix) {
            try await importQrCodeData(from: url)
        } else {
            try await importFileData(from: url)
        }
    }
    
    func importFileData(_ data: Data) async throws {
        let data = try DataType(compressedData: data)
        try await importer(data)
    }
    
    func importFileData(from url: URL) async throws {
        _ = url.startAccessingSecurityScopedResource()
        let data = try DataType(compressedDataAt: url)
        try await importer(data)
    }

    func importQrCodeData(from url: URL) async throws {
        let data = try DataType(qrCodeDataUrl: url, urlPrefix: qrCodeUrlPrefix)
        try await importer(data)
    }
}
