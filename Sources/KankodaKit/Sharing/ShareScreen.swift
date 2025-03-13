//
//  ShareScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-03-13.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit

/// This protocol can be implemented by any view that can be
/// used to share data by presenting a share sheet.
public protocol ShareScreen: View {

    var sheet: SheetContext { get }
}

@MainActor
public extension ShareScreen {

    func share(_ url: URL) {
        #if os(iOS)
        sheet.present(ShareSheet(activityItems: [url]))
        #endif
    }
    
    func share(_ image: ImageRepresentable) {
        #if os(iOS)
        sheet.present(ShareSheet(activityItems: [image]))
        #endif
    }
}
