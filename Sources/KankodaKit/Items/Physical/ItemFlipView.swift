//
//  ItemFlipView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-07-11.
//  Copyright © 2022-2024 Kankoda. All rights reserved.
//

import SwiftUI
import SwiftUIKit
import UniformTypeIdentifiers

/// This view can be flipped to show the front and back side.
public struct ItemFlipView<
    Item: Identifiable,
    ItemView: View>: View {

    /// Create a flip view.
    ///
    /// - Parameters:
    ///   - item: The item to display.
    ///   - isFlipped: Whether or not the item view is flipped.
    ///   - itemView: The view builder used to render item views.
    public init(
        item: Item,
        isFlipped: Binding<Bool>,
        accessibilityHint: String = "Tap or swipe to flip",
        @ViewBuilder itemView: @escaping ItemViewBuilder
    ) {
        self.item = item
        self.isFlipped = isFlipped
        self.accessibilityHint = accessibilityHint
        self.itemView = itemView
    }

    public typealias ItemViewBuilder = (Item, ItemFace) -> ItemView

    private let item: Item
    private let isFlipped: Binding<Bool>
    private let accessibilityHint: String
    private let itemView: ItemViewBuilder
    
    public var body: some View {
        content
            .accessibilityHint(accessibilityHint)
    }
}

private extension ItemFlipView {
    
    var content: some View {
        #if os(tvOS)
        FlipView(
            front: itemView(item, .front),
            back: itemView(item, .back),
            isFlipped: isFlipped,
            tapDirection: .right
        )
        #else
        FlipView(
            front: itemView(item, .front),
            back: itemView(item, .back),
            isFlipped: isFlipped,
            tapDirection: .right,
            swipeDirections: [.right, .left]
        )
        #endif
    }
}

#Preview {

    struct Preview: View {

        @State
        private var isItemFlipped = false

        var body: some View {
            VStack {
                ItemFlipView(
                    item: FlipItem(),
                    isFlipped: $isItemFlipped
                ) { _, face in
                    switch face {
                    case .front: Color.red
                    case .back: Color.blue
                    }
                }
            }.padding()
        }
    }

    return Preview()
}

private struct FlipItem: Identifiable {
    
    var id: UUID { .init() }
}
