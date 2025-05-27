//
//  PremiumTip.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-01-17.
//  Copyright © 2025 Daniel Saidi. All rights reserved.
//

import TipKit
import SwiftUI

/// This view can be used to show premium tips.
@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
public struct PremiumTipView<PremiumScreen: AppScreenType>: View {
    
    public init(
        tip: PremiumTip,
        isPremiumActive: Bool,
        premiumScreen: PremiumScreen,
        imageSize: Double = 30
    ) {
        self.tip = tip
        self.isPremiumActive = isPremiumActive
        self.premiumScreen = premiumScreen
        self.imageSize = .init(width: imageSize, height: imageSize)
    }
    
    private let premiumScreen: PremiumScreen
    private let isPremiumActive: Bool
    private let imageSize: CGSize
    
    @State private var isSheetPresented = false
    @State private var tip: PremiumTip
    
    public var body: some View {
        if !isPremiumActive {
            TipView(tip)
                .padding()
                .sheet(isPresented: $isSheetPresented, content: sheetContent)
                .symbolVariant(.fill)
                .task { setupTipAction() }
                .tipBackground(.ultraThinMaterial)
                .tipImageSize(imageSize)
                .tipImageStyle(.orange)
        }
    }
}

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, visionOS 2.0, *)
private extension PremiumTipView {
    
    func sheetContent() -> some View {
        NavigationStack {
            premiumScreen.screenContent
        }
    }
    
    func setupTipAction() {
        tip.action = {
            Task { @MainActor in
                isSheetPresented = true
            }
        }
    }
}

/// This is a tip for premium features.
///
/// You can provide a `feature` to present an individual tip
/// for specific features. Omit this to present a single tip.
///
/// You can set the ``isPremiumActive`` parameter to control
/// if the tips should be presented or not.
///
/// > Note: The various text values have quite strange types,
/// which due to how Apple has defines their APIs. This type
/// uses `LocalizedStringKey` if possible externally, but it
/// must convert those values to `Text` due to the `Sendable`
/// constraint of `Tip`. The `message` must be `Text?`, else
/// it doesn't show. The `actionTitle` must be `String`.
public struct PremiumTip: Tip {
    
    public init(
        feature: String? = nil,
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        actionTitle: String,
        action: ActionButtonAction? = nil
    ) {
        self.id = "com.kankoda.tip.premium.\(feature ?? "general")"
        self.title = Text(title)
        self.message = Text(message)
        self.actionTitle = actionTitle
    }
    
    public typealias ActionButtonAction = @Sendable () -> Void
    
    @Parameter public static var isPremiumActive: Bool = false
    
    public let id: String
    public let title: Text
    public let message: Text?   // Must be optional, else it won't show.
    public let actionTitle: String
    public let image: Image? = Image.premium  // MUST be an Image?
    
    public var action: @Sendable () -> Void = { }
    
    public var actions: [Action] {
        [
            .init(title: actionTitle, perform: action)
        ]
    }
    
    public var rules: [Rule] {
        #Rule(PremiumTip.$isPremiumActive) { $0 == false }
    }
}

private struct EmptyPremiumScreen: AppScreenType {
    
    init() {
        try? Tips.configure()
    }
    
    var screenTitle: LocalizedStringKey { "" }
    var screenContent: Color { Color.red }
    var isAppSettingsScreen: Bool { false }
    var labelTitle: LocalizedStringKey { "" }
    var labelIcon: Image { .bug }
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
            // PremiumTip.isPremiumActive = false
        }
        .withBottomTipView(
            PremiumTipView(
                tip: PremiumTip(
                    feature: "icons",
                    title: "Preview.TipTitle",
                    message: "Preview.TipMessage",
                    actionTitle: "Preview.TipAction"
                ),
                isPremiumActive: false,
                premiumScreen: EmptyPremiumScreen()
            )
        )
    } else {
        // Fallback on earlier versions
    }
}
