//
//  StorySlideshow.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

import SwiftUI

/**
 This is a standard story slideshow slide view, which should
 be used by standard slideshows to render each slide.

 The view has a title, text and image, optional image config
 parameters, as well as an optional primary button.
 */
public struct StorySlideshowSlide: View {

    /**
     Create a story slideshow slide view.

     Only change the image scale factor and alignment if the
     image should stick out of the edges. This is true for a
     few screens in the various Figma files, but not for all.

     Make sure to set a primary button text when you provide
     a primary action, otherwise the button is going to have
     no text.

     - Parameters:
       - title: The slide title.
       - text: The slide text.
       - image: The background image of the slide.
       - imageScaleFactor: The scale factor to apply to the image, by default `1`.
       - imageAlignment: The alignment apply to the image, by default `.bottom`.
       - style: The style to use, by default ``StorySlideshowSlideStyleStyle/standard``.
     **/
    public init(
        title: String,
        text: String,
        image: Image,
        imageScaleFactor: Double = 1,
        imageAlignment: UnitPoint = .bottom,
        style: StorySlideshowSlideStyleStyle = .standard
    ) {
        self.title = title
        self.text = text
        self.image = image
        self.imageScaleFactor = imageScaleFactor
        self.imageAlignment = imageAlignment
        self.style = style
    }

    private let title: String
    private let text: String
    private let image: Image
    private let imageScaleFactor: Double
    private let imageAlignment: UnitPoint
    private let style: StorySlideshowSlideStyleStyle

    public var body: some View {
        ZStack(alignment: .bottom) {
            backgroundImage

            VStack(spacing: 16) {
                Text(title)
                    .font(style.titleFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Text(text)
                    .font(style.textFont)
                    .frame(maxWidth: .infinity, alignment: .leading)
                Spacer()
            }
        }
    }
}

private extension StorySlideshowSlide {

    var backgroundImage: some View {
        backgroundImageView
            .scaleEffect(imageScaleFactor, anchor: imageAlignment)
    }

    var backgroundImageView: some View {
        image
            .resizable()
            .aspectRatio(contentMode: .fit)
    }
}

struct StorySlideshowSlide_Previews: PreviewProvider {
    static var previews: some View {
        StorySlideshowSlide(
            title: "Manage your loans – all in one place",
            text: "Track, pay, and refinance your loans so you can be in control of your debt. ",
            image: Image(systemName: "rectangle.and.pencil.and.ellipsis"),
            imageScaleFactor: 1.2,
            imageAlignment: .bottomTrailing
        )
    }
}
