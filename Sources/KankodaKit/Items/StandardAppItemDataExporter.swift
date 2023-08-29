//
//  StandardAppItemDataExporter.swift
//  WallyKit
//
//  Created by Daniel Saidi on 2022-07-03.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import Foundation
import UniformTypeIdentifiers

/**
 This exporter can export ``AppItemData`` to a file, using a
 certain `UTType`.
 */
public class StandardAppItemDataExporter: AppItemDataExporter {

    /**
     Create a standard data exporter.

     - Parameters:
       - type: The file's uniform data type.
       - fileManager: The file manager to use to export, by default `.default`.
       - directory: The directory to generate the export files in, by default `.cachesDirectory`.
     */
    public init(
        type: UTType,
        fileManager: FileManager = .default,
        directory: FileManager.SearchPathDirectory = .cachesDirectory
    ) {
        self.type = type
        self.directory = directory
        self.fileManager = fileManager
    }

    /// These errors can be thrown while exporting.
    public enum ExportError: Error {

        /// There was an error generating a url for the file.
        case errorGeneratingUrl
    }

    private let directory: FileManager.SearchPathDirectory
    private let fileManager: FileManager
    private let type: UTType

    public func generateExportFile(for data: any AppItemData) async throws -> URL {
        let fileData = try data.toData()
        guard let url = fileUrl(for: data) else { throw ExportError.errorGeneratingUrl }
        try fileData.write(to: url, options: .atomicWrite)
        return url
    }
}

private extension StandardAppItemDataExporter {

    func fileUrl(for data: any AppItemData) -> URL? {
        fileManager.urls(for: .cachesDirectory, in: .userDomainMask)
            .first?
            .appendingPathComponent(data.name)
            .appendingPathExtension(for: type)
    }
}
