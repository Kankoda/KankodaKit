//
//  DiagonalScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-08-28.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view can be used to create Kankoda-diagonal screens.

 The screen has a custom title icon, a customizable diagonal
 header line and scrollable content.
 */
public struct DiagonalScreen<TitleView: View, Content: View, Background: View>: View {

    public init(
        titleView: TitleView,
        diagonalColor: Color,
        headerHeight: CGFloat = 200,
        content: @escaping () -> Content,
        background: @escaping () -> Background
    ) {
        self.titleView = titleView
        self.diagonalColor = diagonalColor
        self.headerHeight = headerHeight
        self.content = content
        self.background = background
    }

    private let titleView: TitleView
    private let diagonalColor: Color
    private let headerHeight: CGFloat
    private let content: () -> Content
    private let background: () -> Background

    public var body: some View {
        GeometryReader { geo in
            ZStack {
                backgroundView
                ScrollView {
                    ZStack(alignment: .top) {
                        diagonalView(for: geo)
                        contentView(for: geo)
                    }
                    .contentShape(Rectangle())
                }.edgesIgnoringSafeArea(.horizontal)
            }
        }
    }
}

private extension DiagonalScreen {

    var backgroundView: some View {
        VStack(spacing: 0) {
            background()
            diagonalColor
        }.ignoresSafeArea()
    }

    func contentView(for geo: GeometryProxy) -> some View {
        VStack {
            titleView
            content()
                .frame(maxWidth: .infinity)
                .padding(.leading, geo.safeAreaInsets.leading)
                .padding(.trailing, geo.safeAreaInsets.trailing)
                .background(diagonalColor)
        }
        
    }

    func diagonalView(for geo: GeometryProxy) -> some View {
        Diagonal(
            diagonalColor,
            headerHeight: geo.shouldCompressHeader ? 0.75 * headerHeight : headerHeight
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

struct DiagonalScreen_Previews: PreviewProvider {
    
    static var previews: some View {
        NavigationStack {
            DiagonalScreen(
                titleView: Color.green.frame(square: 300),
                diagonalColor: .yellow// .opacity(0.4)
            ) {
                VStack {
                    Text("1")
                    Text("2")
                    Text("3")
                }
            } background: {
                Color.red
            }
            .navigationTitle("Testing")
            .navigationBarTitleDisplayMode(.inline)
        }
        // .previewInterfaceOrientation(.landscapeLeft)
    }
}
