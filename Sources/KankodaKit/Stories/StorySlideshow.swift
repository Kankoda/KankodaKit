//
//  StorySlideshow.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2022-09-04.
//  Copyright © 2022-2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import Combine
import SwiftUI

/**
 This slideshow automatically swipes through a set of slides.
 */
public struct StorySlideshow<StorySlide, BackgroundView: View, ButtonView: View, SlideView: View>: View {
    
    /**
     Create a story slideshow.
     
     - Parameters:
       - slides: The slides to present.
       - config: The configuration to use, by default `.standard`.
       - style: The style to use, by default `.standard`.
       - onStoryCompleted: The action to trigger once the story completes.
       - background: The background to render for a certain slide.
       - button: The bottommost button to render for a certain slide.
     */
    public init(
        slides: [StorySlide],
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
    
    private let slides: [StorySlide]
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


// MARK: - Typealiases

public extension StorySlideshow {
    
    /// A function used to generate a slide background view.
    typealias BackgroundBuilder = (StorySlide) -> BackgroundView
    
    /// A function used to generate a slide primary button.
    typealias ButtonBuilder = (StorySlide) -> ButtonView
    
    /// A function used to generate a slide view.
    typealias SlideViewBuilder = (StorySlide) -> SlideView
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
    
    var currentSlide: StorySlide {
        slides[currentIndex]
    }
    
    var progressViews: some View {
        HStack {
            ForEach(0..<slides.count, id: \.self) { index in
                Button {
                    setNewIndex(index)
                } label: {
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
        if config.isAnimated {
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


// MARK: - Configuration

/**
 This struct can be used to configure a ``StorySlideshow``.
 */
public struct StorySlideshowConfiguration {
    
    /**
     Create a slideshow configuration.
     
     - Parameters:
       - isAnimated: Whether or not the slideshow should animates the slide, by default `true`.
       - slideDuration: The duration of each slide, by default `5`.
       - timeTickIncrement: The duration of each tick, by default `0.05`.
       - nextAccessibilityLabel: The accessibility label for the next button overlay, by default "Next".
       - previousAccessibilityLabel: The accessibility label for the previous button overlay, by default "Previous".
     */
    public init(
        isAnimated: Bool = true,
        slideDuration: TimeInterval = 5,
        timeTickIncrement: TimeInterval = 0.05,
        nextAccessibilityLabel: String = "Next",
        previousAccessibilityLabel: String = "Previous"
    ) {
        self.isAnimated = isAnimated
        self.slideDuration = slideDuration
        self.timerTickIncrement = timeTickIncrement
        self.nextAccessibilityLabel = nextAccessibilityLabel
        self.previousAccessibilityLabel = previousAccessibilityLabel
    }
    
    /// Whether or not the slideshow animates the slide transitions.
    public var isAnimated: Bool
    
    /// The duration of each slide.
    public var slideDuration: TimeInterval
    
    /// The duration increment per tick.
    public var timerTickIncrement: TimeInterval
    
    /// The accessibility label for the next button overlay.
    public var nextAccessibilityLabel: String
    
    /// The accessibility label for the previous button overlay.
    public var previousAccessibilityLabel: String
}

public extension StorySlideshowConfiguration {
    
    /// This is a standard story slideshow configuration.
    static var standard = Self.init()
}


// MARK: - Style

/**
 This style can be used to style a ``StorySlideshow`` view.
 */
public struct StorySlideshowStyle {

    /**
     Create a story slideshow style.

     - Parameters:
       - progressBarBackgroundColor: The color to use below the progress bar, by default `.primary`.
       - progressBarForegroundColor: The color to use for the progress bar, by default `.primary` with opacity.
       - progressBarHeight: The height of the progress bar, by default `3.0`.
     */
    public init(
        progressBarBackgroundColor: Color = .primary.opacity(0.2),
        progressBarForegroundColor: Color = .primary,
        progressBarHeight: Double = 3.0
    ) {
        self.progressBarBackgroundColor = progressBarBackgroundColor
        self.progressBarForegroundColor = progressBarForegroundColor
        self.progressBarHeight = progressBarHeight
    }

    /// The color to use below the progress bar.
    public var progressBarBackgroundColor: Color

    /// The color to use for the progress bar.
    public var progressBarForegroundColor: Color

    /// The height of the progress bar.
    public var progressBarHeight: Double
}

public extension StorySlideshowStyle {

    /// This is a standard story slideshow style.
    static var standard = Self.init()
}


// MARK: - Preview

struct Stories_Slideshow_Previews: PreviewProvider {
    
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
                button: primaryButton,
                slideView: slide
            )
        }
        
        func slide(for color: Color) -> some View {
            StorySlide(
                title: "This is a slideshow with color happiness",
                text: "This is one of the many slides in this colorful slideshow, namely slide \((slides.firstIndex(of: color) ?? 0) + 1)/\(slides.count).",
                image: Image(systemName: "rectangle.and.pencil.and.ellipsis")
            )
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
