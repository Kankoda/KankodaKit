//
//  AppDataImporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import Foundation

/**
 This protocol can be implemented by types that can import a
 type that implements ``AppData``.
 */
public protocol AppDataImporter {
    
    func importData(from url: URL) async throws
}
