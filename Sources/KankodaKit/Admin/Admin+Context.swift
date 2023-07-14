//
//  Admin+Context.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-06-01.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

public extension Admin {
    
    /**
     This class can manage the admin mode of an app.
     */
    class Context: ObservableObject {
        
        /// Whether or not admin mode is enabled.
        @AppStorage("\(PackageInfo.appStoragePrefix)admin.isAdminModeEnabled")
        public var isAdminModeEnabled = false
    }
}
