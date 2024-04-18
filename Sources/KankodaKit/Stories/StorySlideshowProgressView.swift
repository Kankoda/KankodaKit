//
//  StorySlideshowProgressView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2024 Kankoda. All rights reserved.
//

#if os(iOS)
import SwiftUI

/// This view can present progress in a story slideshow.
public struct StorySlideshowProgressView: View {
    
    /// Create a slideshow progress view.
    ///
    /// - Parameters:
    ///   - index: The slide index.
    ///   - slideshowIndex: The current slideshow index.
    ///   - slideshowProgress: The current slideshow progress.
    ///   - style: The style to use, by default ``StorySlideshowStyle/standard``.
    public init(
        index: Int,
        slideshowIndex: Int,
        slideshowProgress: Double,
        style: StorySlideshowStyle = .standard
    ) {
        self.index = index
        self.slideshowIndex = slideshowIndex
        self.slideshowProgress = slideshowProgress
        self.style = style
    }
    
    private let index: Int
    private let slideshowIndex: Int
    private let slideshowProgress: Double
    private let style: StorySlideshowStyle
    
    public var body: some View {
        GeometryReader { geometry in
            Capsule()
                .fill(style.progressBarBackgroundColor)
            Capsule()
                .fill(style.progressBarForegroundColor)
                .frame(width: barWidth(for: geometry), alignment: .leading)
        }
        .frame(height: style.progressBarHeight)
    }
}

private extension StorySlideshowProgressView {

    var progress: Double {
        if index < slideshowIndex { return 1 }
        if index > slideshowIndex { return 0 }
        return slideshowProgress
    }

    func barWidth(for geo: GeometryProxy) -> Double {
        geo.size.width * progress
    }
}

#Preview {

    let slideshowIndex = 4
    let slideshowProgress = 0.5

    return HStack {
        ForEach(0...5, id: \.self) {
            StorySlideshowProgressView(
                index: $0,
                slideshowIndex: slideshowIndex,
                slideshowProgress: slideshowProgress,
                style: .preview
            )
        }
    }.padding()
}

private extension StorySlideshowStyle {

    static var preview = Self.init(
        progressBarBackgroundColor: .blue,
        progressBarForegroundColor: .yellow,
        progressBarHeight: 10
    )
}
#endif
