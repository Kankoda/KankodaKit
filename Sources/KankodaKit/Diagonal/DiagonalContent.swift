//
//  DiagonalContent.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-28.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to create diagonal styled content for
 Kankoda apps.
 */
public struct DiagonalContent<Background: View, DiagonalStyle: ShapeStyle, Content: View>: View {

    public init(
        background: Background,
        diagonal: DiagonalStyle,
        diagonalOffset: CGFloat = 200,
        content: @escaping () -> Content
    ) {
        self.background = background
        self.diagonal = diagonal
        self.diagonalOffset = diagonalOffset
        self.content = content
    }

    private let background: Background
    private let diagonal: DiagonalStyle
    private let diagonalOffset: CGFloat
    private let content: () -> Content

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
            background
            Color.clear.background(diagonal)
        }.ignoresSafeArea()
    }
    
    func scrollView(for geo: GeometryProxy) -> some View {
        ScrollView {
            ZStack(alignment: .top) {
                diagonalView(for: geo)
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
        Diagonal(
            diagonal,
            diagonalOffset: geo.shouldCompressHeader ? 0.75 * diagonalOffset : diagonalOffset
        ).frame(height: geo.size.height)
    }
}

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

struct DiagonalContent_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            DiagonalContent(
                background: Color.red,
                diagonal: .yellow,// .opacity(0.4)
                diagonalOffset: 250
            ) {
                VStack(spacing: 20) {
                    RoundedRectangle(cornerRadius: 20).fill(.green).frame(square: 300)
                    Text("1")
                    Text("2")
                    Text("3")
                }
            }
            .navigationTitle("Testing")
            #if os(iOS)
            .navigationBarTitleDisplayMode(.inline)
            #endif
        }
        // .previewInterfaceOrientation(.landscapeLeft)
    }
}
