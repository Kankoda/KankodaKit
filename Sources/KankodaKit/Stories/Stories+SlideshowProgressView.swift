//
//  Stories+SlideshowProgressView.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import SwiftUI

public extension Stories {
    
    /**
     This view is used to present multi-page progress within
     a story slideshow.
     */
    struct SlideshowProgressView: View {
        
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
            style: SlideshowStyle = .standard
        ) {
            self.index = index
            self.slideshowIndex = slideshowIndex
            self.slideshowProgress = slideshowProgress
            self.style = style
        }
        
        private let index: Int
        private let slideshowIndex: Int
        private let slideshowProgress: Double
        private let style: SlideshowStyle
        
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
}

private extension Stories.SlideshowProgressView {

    var progress: Double {
        if index < slideshowIndex { return 1 }
        if index > slideshowIndex { return 0 }
        return slideshowProgress
    }

    func barWidth(for geo: GeometryProxy) -> Double {
        geo.size.width * progress
    }
}

struct Stories_SlideshowProgressView_Previews: PreviewProvider {

    static let slideshowIndex = 4
    static let slideshowProgress = 0.5

    static var previews: some View {
        HStack {
            ForEach(0...5, id: \.self) {
                Stories.SlideshowProgressView(
                    index: $0,
                    slideshowIndex: slideshowIndex,
                    slideshowProgress: slideshowProgress,
                    style: .preview
                )
            }
        }.padding()
    }
}

private extension Stories.SlideshowStyle {

    static var preview = Self.init(
        progressBarBackgroundColor: .blue,
        progressBarForegroundColor: .yellow,
        progressBarHeight: 10
    )
}
#endif
