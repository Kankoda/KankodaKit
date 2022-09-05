//
//  StorySlideshow.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Combine
import SwiftUI

/**
 This view mimics the Instagram story slideshow, which has a
 number of slides that it presents in sequence.
 */
public struct StorySlideshow<Slide, BackgroundView: View, ButtonView: View, SlideView: View>: View {

    /**
     Create a story slideshow.

     - Parameters:
       - slides: The slides to present.
       - config: The configuration to use, by default ``StorySlideshowConfiguration/standard``.
       - style: The style to use, by default ``StorySlideshowStyle/standard``.
       - onStoryCompleted: The action to trigger once the story completes.
       - background: The background to render for a certain slide.
       - button: The bottommost button to render for a certain slide.

     */
    public init(
        slides: [Slide],
        config: StorySlideshowConfiguration = .standard,
        style: StorySlideshowStyle = .standard,
        onStoryCompleted: @escaping () -> Void,
        background: @escaping BackgroundBuilder,
        button: @escaping ButtonBuilder,
        slideView: @escaping SlideViewBuilder
    ) {
        self.slides = slides
        self.config = config
        self.style = style
        self.onStoryCompleted = onStoryCompleted
        self.backgroundBuilder = background
        self.buttonBuilder = button
        self.slideViewBuilder = slideView
        self.timer = Timer.publish(
            every: config.slideDuration * config.timerTickIncrement,
            on: .main,
            in: .common
        ).autoconnect()
    }

    /// A function used to generate a slide background view.
    public typealias BackgroundBuilder = (Slide) -> BackgroundView

    /// A function used to generate a slide primary button.
    public typealias ButtonBuilder = (Slide) -> ButtonView

    /// A function used to generate a slide view.
    public typealias SlideViewBuilder = (Slide) -> SlideView

    private let slides: [Slide]
    private let config: StorySlideshowConfiguration
    private let style: StorySlideshowStyle
    private let timer: Publishers.Autoconnect<Timer.TimerPublisher>
    private let onStoryCompleted: () -> Void
    private let backgroundBuilder: BackgroundBuilder
    private let buttonBuilder: ButtonBuilder
    private let slideViewBuilder: SlideViewBuilder

    @State
    private var currentIndex: Int = 0

    @State
    private var currentProgress: Double = 0

    @State
    private var isTimerRunning = true

    public var body: some View {
        VStack {   // Needed for the nested timer to trigger
            VStack {
                progressViews
                slideViews
                button
            }
            .onReceive(timer) { _ in
                guard isTimerRunning else { return }
                handleTimerTick()
            }
        }.background(backgroundColor)
    }
}


// MARK: - View Builders

private extension StorySlideshow {

    var backgroundColor: some View {
        backgroundBuilder(currentSlide)
            .ignoresSafeArea()
    }

    var button: some View {
        buttonBuilder(currentSlide)
            .padding()
    }

    var currentSlide: Slide {
        slides[currentIndex]
    }

    var progressViews: some View {
        HStack {
            ForEach(0..<slides.count, id: \.self) { index in
                Button(action: { setNewIndex(index) }) {
                    progressView(index)
                }
            }
        }
        .padding(.horizontal)
    }

    var slideViews: some View {
        TabView(selection: $currentIndex) {
            ForEach(0..<slides.count, id: \.self) {
                slideViewBuilder(slides[$0])
                    .padding()
                    .tag($0)
            }
        }
        .tabViewStyle(.page(indexDisplayMode: .never))
        .overlay(
            HStack(spacing: 0) {
                overlayControl(next: false)
                overlayControl(next: true)
            }
        )
    }

    func progressView(_ slideIndex: Int) -> some View {
        StorySlideshowProgressView(
            index: slideIndex,
            slideshowIndex: currentIndex,
            slideshowProgress: currentProgress
        )
        .padding(.vertical)
        .contentShape(Rectangle())
    }

    func overlayControl(next: Bool) -> some View {
        Color.clear
            .contentShape(Rectangle())
            .accessibilityLabel(Text(
                next ? config.nextAccessibilityLabel : config.previousAccessibilityLabel))
            .onTapGesture {
                next ? nextSlide() : previousSlide()
            }
            .onLongPressGesture(
                minimumDuration: 60,
                maximumDistance: 100,
                perform: {},
                onPressingChanged: {
                    isTimerRunning = !$0
                }
            )
    }
}

// MARK: - Slide Controls

private extension StorySlideshow {

    var isFullProgress: Bool {
        currentProgress >= 1
    }

    func endSlides() {
        currentProgress = 1
        isTimerRunning = false
        onStoryCompleted()
    }

    func handleTimerTick() {
        if isFullProgress { return nextSlide() }
        withAnimation {
            let newProgress = currentProgress + config.timerTickIncrement
            currentProgress = min(newProgress, 1)
        }
    }

    func nextSlide() {
        let index = slides.index(after: currentIndex)
        guard index < slides.endIndex else { return endSlides() }
        setNewIndex(index)
    }

    func previousSlide() {
        let index = slides.index(before: currentIndex)
        guard index >= slides.startIndex else { return }
        setNewIndex(index)
    }

    func setNewIndex(_ index: Int) {
        if !config.isAnimated {
            withAnimation {
                setNewIndexPlain(index)
            }
        } else {
            setNewIndexPlain(index)
        }
    }

    func setNewIndexPlain(_ index: Int) {
        currentIndex = index
        currentProgress = 0.0
        isTimerRunning = true
    }
}

struct StorySlideshow_Previews: PreviewProvider {

    struct Preview: View {

        var slides: [Color] = [.red, .green, .blue, .purple]

        @State
        private var buttonTapCount = 0

        @State
        private var buttonText = "Do it!"

        var body: some View {
            StorySlideshow(
                slides: slides,
                config: .standard,
                style: .standard,
                onStoryCompleted: handleStoryCompleted,
                background: { $0 },
                button: primaryButton
            ) { color in
                StorySlideshowSlide(
                    title: "This is a slideshow with color happiness",
                    text: "This is one of the many slides in this colorful slideshow, namely slide \((slides.firstIndex(of: color) ?? 0) + 1)/\(slides.count).",
                    image: Image(systemName: "rectangle.and.pencil.and.ellipsis"),
                    imageScaleFactor: 1.2,
                    imageAlignment: .bottomTrailing
                )
            }
        }

        func primaryButton(for color: Color) -> some View {
            Button(buttonText, action: handleButtonTap)
                .buttonStyle(.borderedProminent)
                .controlSize(.large)
        }

        func handleButtonTap() {
            buttonTapCount += 1
            buttonText = "Button tapped \(buttonTapCount) times!"
        }

        func handleStoryCompleted() {
            buttonText = "Story complete!"
        }
    }

    static var previews: some View {
        Preview()
    }
}
#endif
