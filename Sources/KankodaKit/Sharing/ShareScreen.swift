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
public protocol ShareScreen: View {}

/// This enum can be used to share data, for instance within
/// a ``ShareScreen``.
public enum ShareItem: Identifiable {

    case url(URL)
    case image(ImageRepresentable)
}

public extension ShareItem {

    var id: String {
        switch self {
        case .url(let url): url.absoluteString
        case .image(let image): image.description
        }
    }

    var shareSheet: ShareSheet {
        switch self {
        case .url(let url): ShareSheet(activityItems: [url])
        case .image(let image): ShareSheet(activityItems: [image])
        }
    }
}

@MainActor
public extension ShareScreen {

    func share(_ url: URL, to binding: Binding<ShareItem?>) {
        binding.wrappedValue = .url(url)
    }
    
    func share(_ image: ImageRepresentable, to binding: Binding<ShareItem?>) {
        binding.wrappedValue = .image(image)
    }
}
