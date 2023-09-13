//
//  StandardAppDataImporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This importer imports compressed data for the provided type.
 
 The `qrCodeUrlPrefix` is optional, and only used when using
 QR codes to import and export small amounts of data. It has
 a default value of `qr:`.
 */
open class StandardAppDataImporter<DataType: AppData>: AppDataImporter {
    
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

    func importFileData(from url: URL) async throws {
        _ = url.startAccessingSecurityScopedResource()
        let data = try DataType(compressedDataAt: url)
        try await importData(data)
    }

    func importQrCodeData(from url: URL) async throws {
        let data = try DataType(qrCodeDataUrl: url, urlPrefix: qrCodeUrlPrefix)
        try await importData(data)
    }
}

@MainActor
private extension StandardAppDataImporter {

    func importData(_ data: DataType) async throws {
        try await importer(data)
    }
}
