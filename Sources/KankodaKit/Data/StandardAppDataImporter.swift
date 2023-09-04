//
//  StandardAppDataImporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This is a standard ``AppDataImporter`` implementation.
 */
public class StandardAppDataImporter<DataType: AppData>: AppDataImporter {
    
    public init(
        qrCodeUrlPrefix: String,
        importer: @escaping (DataType) -> Void
    ) {
        self.qrCodeUrlPrefix = qrCodeUrlPrefix
        self.importer = importer
    }
    
    private let qrCodeUrlPrefix: String
    private let importer: (DataType) -> Void
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
        importer(data)
    }
}
