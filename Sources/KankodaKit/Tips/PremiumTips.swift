//
//  PremiumTips.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-17.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import TipKit
import SwiftUI

/// This view can be used to highlight premium-related tips.
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
public struct PremiumTipView: View {
    
    public init(
        _ tip: any Tip,
        imageSize: Double = 30
    ) {
        self.tip = tip
        self.imageSize = .init(width: imageSize, height: imageSize)
    }
    
    let tip: any Tip
    let imageSize: CGSize
    
    public var body: some View {
        TipView(tip)
            .padding()
            .symbolVariant(.fill)
            .tipBackground(.ultraThinMaterial)
            .tipImageSize(imageSize)
            .tipImageStyle(.orange)
    }
}

/// This is a tip for premium features.
///
/// In order to be able keep this within the package, and to
/// localize it properly, each new premium feature type must
/// be added to this tip.
public struct PremiumFeatureTip<PremiumScreen: AppScreenType>: Tip {
    
    public init(
        feature: Feature,
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        actionTitle: String,
        premiumScreen: PremiumScreen
    ) {
        self.feature = feature
        self.premiumScreen = premiumScreen
        self.id = "com.kankoda.tip.premiumfeature.\(feature.id)"
        self.title = Text(title)
        self.message = Text(message)
        self.actionTitle = actionTitle
    }
    
    public enum Feature: String, Identifiable, Sendable {
        case icons, skins
        public var id: String { rawValue }
    }
    
    private let feature: Feature
    private let premiumScreen: PremiumScreen
    
    public let id: String
    public let title: Text
    public let message: Text?
    public let actionTitle: String
    public let image: Image? = Image.premium  // MUST be an Image?
    
    public var actions: [Action] {
        [
            .init(title: actionTitle, perform: {
                Task {
                    await MainActor.run {
                        AppEnvironment.sheetContext.present(
                            NavigationStack {
                                premiumScreen.screenContent
                            }
                        )
                    }
                }
            })
        ]
    }
}

private struct EmptyPremiumScreen: AppScreenType {
    
    init() {
        try? Tips.configure()
    }
    
    var screenTitle: LocalizedStringKey { "Preview.EmptyScreen" }
    var screenContent: Color { Color.red }
    var labelTitle: LocalizedStringKey { "Preview.EmptyScreen" }
    var labelIcon: Image { .bug }
}

#Preview {
    
    if #available(iOS 18.0, macOS 15.0, *) {
        List {
            ForEach(0...40, id: \.self) { _ in
                Color.random()
            }
        }
        .withBottomTipView(
            PremiumTipView(
                PremiumFeatureTip(
                    feature: .icons,
                    title: "Preview.TipTitle",
                    message: "Preview.TipMessage",
                    actionTitle: "Preview.TipAction",
                    premiumScreen: EmptyPremiumScreen()
                )
            )
        )
    } else {
        // Fallback on earlier versions
    }
}
