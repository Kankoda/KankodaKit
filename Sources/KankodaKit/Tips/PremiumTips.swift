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
public struct PremiumTipView<PremiumScreen: AppScreenType>: View {
    
    public init(
        _ tip: PremiumFeatureTip<PremiumScreen>,
        imageSize: Double = 30
    ) {
        self.tip = tip
        self.imageSize = .init(width: imageSize, height: imageSize)
    }

    private let imageSize: CGSize
    
    @State private var isSheetPresented = false
    @State private var tip: PremiumFeatureTip<PremiumScreen>
    
    public var body: some View {
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

@available(iOS 18.0, macOS 15.0, tvOS 18.0, watchOS 11.0, *)
private extension PremiumTipView {
    
    func sheetContent() -> some View {
        NavigationStack {
            tip.premiumScreen.screenContent
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

/// This is a view model for premium tips.
final class PremiumTipViewViewState: ObservableObject {
    
    @Published var isSheetPresented = false
}

/// This is a tip for premium features.
///
/// In order to be able keep this within the package, and to
/// localize it properly, each new premium feature type must
/// be added to this tip.
///
/// > Note: The various text values have quite strange types,
/// which due to how Apple has defines their APIs. This type
/// uses `LocalizedStringKey` if possible externally, but it
/// must convert those values to `Text` due to the `Sendable`
/// constraint of `Tip`. The `message` must be `Text?`, else
/// it doesn't show. The `actionTitle` must be `String`.
public struct PremiumFeatureTip<PremiumScreen: AppScreenType>: Tip {
    
    public init(
        feature: Feature,
        title: LocalizedStringKey,
        message: LocalizedStringKey,
        actionTitle: String,
        action: ActionButtonAction? = nil,
        premiumScreen: PremiumScreen
    ) {
        self.feature = feature
        self.premiumScreen = premiumScreen
        self.id = "com.kankoda.tip.premiumfeature.\(feature.id)"
        self.title = Text(title)
        self.message = Text(message)
        self.actionTitle = actionTitle
    }
    
    public typealias ActionButtonAction = @Sendable () -> Void
    
    public enum Feature: String, Identifiable, Sendable {
        case icons, skins
        public var id: String { rawValue }
    }
    
    public let feature: Feature
    public let premiumScreen: PremiumScreen
    
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
