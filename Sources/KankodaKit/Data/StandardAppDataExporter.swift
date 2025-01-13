//
//  StandardAppDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import Foundation
import SwiftUIKit
import UniformTypeIdentifiers

/// This exporter exports compressed data.
///
/// The `qrCodeUrlPrefix` is optional, and will only be used
/// by QR codes to import & export small amounts of data.
open class StandardAppDataExporter: AppDataExporter {
    
    public init(
        qrCodeUrlPrefix: String = "qr:"
    ) {
        self.qrCodeUrlPrefix = qrCodeUrlPrefix
    }
    
    private let qrCodeUrlPrefix: String
}

public extension StandardAppDataExporter {
    
    func generateExportFile<DataType: AppData>(
        for data: DataType
    ) async throws -> URL {
        let fileData = try data.toCompressedData()
        let url = fileUrl(for: data)
        try fileData.write(to: url, options: .atomicWrite)
        return url
    }
    
    func generateQrCodeDataString<DataType: AppData>(
        for data: DataType
    ) async throws -> String {
        try data.toQrCodeDataString(withUrlPrefix: qrCodeUrlPrefix)
    }
}

private extension StandardAppDataExporter {

    func fileUrl<DataType: AppData>(
        for data: DataType
    ) -> URL {
        URL.cachesDirectory
            .appendingPathComponent(data.name)
            .appendingPathExtension(for: DataType.uniformType)
    }
}
