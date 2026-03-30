//
//  LocalizedViews.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-11-23.
//  Copyright © 2023-2026 Kankoda. All rights reserved.
//

import SwiftUI

struct LocalizedText: View {
    
    init(
        _ title: LocalizedStringKey
    ) {
        self.title = title
    }
    
    private var title: LocalizedStringKey
    
    var body: some View {
        Text(title, bundle: .module)
    }
}

struct LocalizedLabel<Icon: View>: View {
    
    init(
        _ title: LocalizedStringKey,
        _ icon: Icon
    ) {
        self.title = title
        self.icon = icon
    }
    
    private var title: LocalizedStringKey
    private var icon: Icon
    
    var body: some View {
        Label {
            LocalizedText(title)
        } icon: {
            icon
        }
    }
}

struct LocalizedLink<Icon: View>: View {
    
    init(
        _ title: LocalizedStringKey,
        _ icon: Icon,
        _ url: URL?
    ) {
        self.title = title
        self.icon = icon
        self.url = url
    }
    
    init(
        _ title: LocalizedStringKey,
        _ url: URL?
    ) where Icon == EmptyView {
        self.title = title
        self.icon = nil
        self.url = url
    }
    
    private var title: LocalizedStringKey
    private var icon: Icon?
    private var url: URL?
    
    var body: some View {
        if let url {
            Link(destination: url) {
                if let icon {
                    LocalizedLabel(title, icon)
                } else {
                    LocalizedText(title)
                }
            }
        }
    }
}

#if os(macOS) || os(iOS) || os(watchOS)
struct LocalizedShareLink<Icon: View>: View {
    
    init(
        _ title: LocalizedStringKey,
        _ icon: Icon,
        _ url: URL?
    ) {
        self.title = title
        self.icon = icon
        self.url = url
    }
    
    private var title: LocalizedStringKey
    private var icon: Icon
    private var url: URL?
    
    var body: some View {
        if let url {
            ShareLink(item: url) {
                LocalizedLabel(title, icon)
            }
        }
    }
}
#endif
