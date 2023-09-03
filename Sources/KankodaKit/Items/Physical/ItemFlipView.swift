//
//  AppItemFlipView.swift
//  WallyKit
//
//  Created by Daniel Saidi on 2022-07-11.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI
import SwiftUIKit
import UniformTypeIdentifiers

/**
 This view can be used to render an item that can be flipped
 to show the front and back side.
 */
public struct AppItemFlipView<
    Item: Identifiable,
    ItemView: View>: View {

    /**
     Create a flip view.

     - Parameters:
       - item: The item to display.
       - isFlipped: Whether or not the item view is flipped.
       - itemView: The view builder used to render item views.
     */
    public init(
        item: Item,
        isFlipped: Binding<Bool>,
        @ViewBuilder itemView: @escaping ItemViewBuilder
    ) {
        self.item = item
        self.isFlipped = isFlipped
        self.itemView = itemView
    }

    public typealias ItemViewBuilder = (Item, ItemFace) -> ItemView

    private let item: Item
    private let isFlipped: Binding<Bool>
    private let itemView: ItemViewBuilder

    public var body: some View {
        #if os(tvOS)
        FlipView(
            front: itemView(item, .front),
            back: itemView(item, .back),
            isFlipped: isFlipped,
            tapDirection: .right)
        #else
        FlipView(
            front: itemView(item, .front),
            back: itemView(item, .back),
            isFlipped: isFlipped,
            tapDirection: .right,
            swipeDirections: [.right, .left])
        #endif
    }
}

struct AppItemFlipView_Previews: PreviewProvider {

    struct Preview: View {

        @State
        private var isItemFlipped = false

        var body: some View {
            VStack {
                AppItemFlipView(
                    item: FlipItem(),
                    isFlipped: $isItemFlipped
                ) { item, face in
                    switch face {
                    case .front: Color.red
                    case .back: Color.blue
                    }
                }
            }.padding()
        }
    }

    static var previews: some View {
        Preview()
    }
}

private struct FlipItem: Identifiable {
    
    var id: UUID { .init() }
}
