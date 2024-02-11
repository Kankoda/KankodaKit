//
//  AdminContext.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-01.
//  Copyright © 2023-2024 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This class can manage the admin mode of an app.
 */
public class AdminContext: ObservableObject {
    
    /// Whether or not admin mode is enabled.
    @AppStorage("\(PackageInfo.appStoragePrefix)admin.isAdminModeEnabled")
    public var isAdminModeEnabled = false
}
