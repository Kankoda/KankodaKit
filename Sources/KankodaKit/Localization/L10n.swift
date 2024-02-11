//
//  L10n.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2024-01-19.
//  Copyright © 2024 Kankoda. All rights reserved.
//

import SwiftUI

/// This function can be used to translate localization keys.
func L10n(_ key: String.LocalizationValue) -> String {
        
    String(localized: key, bundle: .module)
}
