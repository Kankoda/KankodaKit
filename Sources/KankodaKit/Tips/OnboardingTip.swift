//
//  OnboardingTip.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-03-20.
//  Copyright © 2025-2026 Kankoda. All rights reserved.
//

import TipKit
import SwiftUI

/// This is a tip for presenting quick onboarding hints.
///
/// You can provide a `feature` to present an individual tip for that feature.
public struct OnboardingTip: Tip {
    
    public init(
        feature: String? = nil,
        title: LocalizedStringKey,
        message: LocalizedStringKey
    ) {
        self.id = "com.kankoda.tip.onboarding.\(feature ?? "general")"
        self.title = Text(title)
        self.message = Text(message)
    }
    
    @Parameter public static var isPremiumActive: Bool = false
    
    public let id: String
    public let title: Text
    public let message: Text?   // Must be optional
    public let image: Image? = Image.lightbulb  // Must be optional
    
    public var rules: [Rule] {
        #Rule(OnboardingTip.$isPremiumActive) { $0 == false }
    }
}

/// This view can be used to show onboarding tips.
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct OnboardingTipView: View {

    public init(
        tip: OnboardingTip,
        imageSize: Double = 30
    ) {
        self.tip = tip
        self.imageSize = .init(width: imageSize, height: imageSize)
    }

    private let imageSize: CGSize

    @State private var tip: OnboardingTip

    public var body: some View {
        TipView(tip)
            .padding()
            .symbolVariant(.fill)
            .tipBackground(.ultraThinMaterial)
            .tipImageSize(imageSize)
            .tipImageStyle(.yellow, .gray)
    }
}

#Preview {
    
    if #available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *) {
        List {
            ForEach(0...40, id: \.self) { _ in
                Color.random()
            }
        }
        .task {
            try? Tips.configure()
            // OnboardingTip.isPremiumActive = false
        }
        .withBottomTipView(
            OnboardingTipView(
                tip: OnboardingTip(
                    feature: "icons",
                    title: "Preview.TipTitle",
                    message: "Preview.TipMessage"
                )
            )
        )
    } else {
        // Fallback on earlier versions
    }
}
