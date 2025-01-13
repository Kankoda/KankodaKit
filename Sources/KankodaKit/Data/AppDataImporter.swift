//
//  AppDataImporter.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-26.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

import Foundation

/// This protocol can be implemented by any type that can be
/// used to import ``AppData`` types.
public protocol AppDataImporter {
    
    func importData(from url: URL) async throws
}
