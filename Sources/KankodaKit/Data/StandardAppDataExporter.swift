//
//  StandardAppDataExporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import SwiftUIKit
import UniformTypeIdentifiers

/**
 This exporter exports compressed data for the provided type.
 */
open class StandardAppDataExporter: AppDataExporter {
    
    public init(
        qrCodeUrlPrefix: String = ""
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
            .appendingPathExtension(for: data.uniformType)
    }
}
