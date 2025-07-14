//
//  DiagonalContent.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-28.
//  Copyright © 2022-2025 Kankoda. All rights reserved.
//

import SwiftUI

/// This view can be used to create diagonal styled content.
///
/// This view uses hacks to make the diagonal behave well in
/// a scroll view. Make sure to use a solid color.
@MainActor
public struct DiagonalContent<Content: View>: View {
    
    public init(
        diagonalOffset: CGFloat = 200,
        content: @escaping () -> Content
    ) {
        self.diagonalOffset = diagonalOffset
        self.content = content
    }
    
    private let diagonalOffset: CGFloat
    private let content: () -> Content
    
    @Environment(\.diagonalStyle) var style
    
    public var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundView
                scrollView(for: geo)
            }
        }
    }
}

private extension DiagonalContent {

    var backgroundView: some View {
        VStack(spacing: 0) {
            style.background
            diagonalBackground
        }
        .ignoresSafeArea()
    }
    
    var diagonalBackground: some View {
        Color.clear.background(style.diagonal)
    }
    
    var scrollBackground: some View {
        VStack {
            Color.clear
            diagonalBackground
        }
    }
    
    func scrollView(for geo: GeometryProxy) -> some View {
        ScrollView {
            ZStack(alignment: .top) {
                diagonalView(for: geo)
                scrollBackground
                contentView(for: geo)
            }
            .contentShape(Rectangle())
        }.edgesIgnoringSafeArea(.horizontal)
    }

    func contentView(for geo: GeometryProxy) -> some View {
        content()
            .frame(maxWidth: .infinity)
            .padding(.leading, geo.safeAreaInsets.leading)
            .padding(.trailing, geo.safeAreaInsets.trailing)
    }

    func diagonalView(for geo: GeometryProxy) -> some View {
        DiagonalShape(
            diagonalOffset: geo.shouldCompressHeader ? 0.75 * diagonalOffset : diagonalOffset
        )
        .fill(style.diagonal)
        .edgesIgnoringSafeArea(.bottom)
        .frame(height: geo.size.height)
    }
}

@MainActor
private extension GeometryProxy {
    
    var isLandscape: Bool { size.height < size.width }
    
    var shouldCompressHeader: Bool {
        #if os(iOS)
        isLandscape && UIDevice.current.userInterfaceIdiom == .phone
        #else
        return false
        #endif
    }
}

#Preview {
    
    func square() -> some View {
        Color.purple.frame(width: 100, height: 100)
    }
    
    return NavigationStack {
        DiagonalContent {
            VStack(spacing: 20) {
                RoundedRectangle(cornerRadius: 20).fill(.green).frame(square: 300)
                square()
                square()
                square()
                square()
                square()
                square()
                square()
                square()
            }
        }
        .navigationTitle("Preview.Testing")
        #if os(iOS)
        .navigationBarTitleDisplayMode(.inline)
        #endif
        .diagonalStyle(.init(
            background: .red,
            diagonal: .yellow.opacity(0.5)
        ))
    }
    // .previewInterfaceOrientation(.landscapeLeft)
}
