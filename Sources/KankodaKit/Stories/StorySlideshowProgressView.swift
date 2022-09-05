//
//  StorySlideshow.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This view is used to present multi-page progress within the
 ``StorySlideshow``. It shows a single slide's progress.

 The ``StorySlideshow`` navigates through its slides, moving
 from 0 to 1 in progress for every slide. This progress view
 then either renders as 1 progress if its index is less than
 the current index, the current progress if it's the current
 index and 0 if its index is greater than the current index.
 */
public struct StorySlideshowProgressView: View {

    /**
     Create a slideshow progress view.

     - Parameters:
       - index: The slide index.
       - slideshowIndex: The current slideshow index.
       - slideshowProgress: The current slideshow progress.
       - style: The style to use, by default ``StorySlideshowStyle/standard``.
     */
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
        ZStack(alignment: .top) {
            GeometryReader { geometry in
                Capsule()
                    .fill(style.progressBarBackgroundColor)
                Capsule()
                    .fill(style.progressBarForegroundColor)
                    .frame(width: barWidth(for: geometry), alignment: .leading)
            }
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

struct StorySlideshowProgressView_Previews: PreviewProvider {

    static let slideshowIndex = 4
    static let slideshowProgress = 0.5

    static var previews: some View {
        HStack {
            ForEach(0...5, id: \.self) {
                StorySlideshowProgressView(
                    index: $0,
                    slideshowIndex: slideshowIndex,
                    slideshowProgress: slideshowProgress,
                    style: .preview)
            }
        }.padding()
    }
}

private extension StorySlideshowStyle {

    static var preview = StorySlideshowStyle(
        progressBarBackgroundColor: .blue,
        progressBarForegroundColor: .yellow,
        progressBarHeight: 10)
}
