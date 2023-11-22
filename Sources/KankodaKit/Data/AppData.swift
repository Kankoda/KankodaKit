//
//  KankodaData.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-07-10.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation
import UniformTypeIdentifiers

/**
 This protocol can be implemented by app-specific data types.
 */
public protocol AppData: Codable {
    
    /// The name to use when exporting the data.
    var name: String { get }
    
    /// The uniform type to use when handling the data.
    static var uniformType: UTType { get }
}

/**
 This error type can be thrown when handling ``AppData``.
 */
public enum AppDataError: Error {
    
    case base64DecodingFailed
}

public extension AppData {
    
    /// Create an instance with raw, uncompressed data.
    init(data: Data) throws {
        self = try JSONDecoder().decode(Self.self, from: data)
    }
    
    /// Create an instance with data from a certain url.
    init(dataAt url: URL) throws {
        let data = try Data(contentsOf: url)
        try self.init(data: data)
    }
    
    /// Create an instance with raw, compressed data.
    init(compressedData data: Data) throws {
        let nsdata = data as NSData
        let unzipped = try nsdata.decompressed(using: .appDataCompression)
        let unzippedData = unzipped as Data
        try self.init(data: unzippedData)
    }
    
    /// Create an instance with data from a certain url.
    init(compressedDataAt url: URL) throws {
        let data = try Data(contentsOf: url)
        try self.init(compressedData: data)
    }
    
    /// Create an instance from a QR code data url.
    init(
        qrCodeDataUrl url: URL,
        urlPrefix prefix: String
    ) throws {
        let urlString = url.absoluteString
        let dataString = urlString
            .replacing("\(prefix)//", with: "")
            .replacing(prefix, with: "")
        guard let data = Data(base64Encoded: dataString) else { throw AppDataError.base64DecodingFailed }
        let nsdata = data as NSData
        let decompressed = try nsdata.decompressed(using: .qrCodeCompression)
        let jsonData = decompressed as Data
        self = try JSONDecoder().decode(Self.self, from: jsonData)
    }
}

public extension AppData {
    
    /// Convert the value to raw, uncompressed data.
    func toData() throws -> Data {
        try JSONEncoder().encode(self)
    }
    
    /// Convert the value to raw, compressed data.
    func toCompressedData() throws -> Data {
        let data = try toData() as NSData
        let compressedData = try data.compressed(using: .appDataCompression)
        return compressedData as Data
    }
    
    /// Convert the value to a QR code data url string.
    func toQrCodeDataString(withUrlPrefix prefix: String) throws -> String {
        let jsonData = try JSONEncoder().encode(self)
        let nsData = jsonData as NSData
        let compressedData = try nsData.compressed(using: .qrCodeCompression) as Data
        let compressedString = compressedData.base64EncodedString()
        let compressedUrl = "\(prefix)\(compressedString)"
        return compressedUrl
    }
}

public extension NSData.CompressionAlgorithm {

    /// An alias for `lzfse`, used to compress domain items.
    static let appDataCompression = NSData.CompressionAlgorithm.lzfse
    
    /// An alias for `lzma`, used to embed data in QR codes.
    static let qrCodeCompression = NSData.CompressionAlgorithm.lzma
}
