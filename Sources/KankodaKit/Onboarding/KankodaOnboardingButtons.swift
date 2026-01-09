//
//  KankodaOnboardingButtons.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025 Kankoda. All rights reserved.
//

import OnboardingKit
import SwiftUI

public struct OnboardingNextPageOrDismissButton<Page>: View {

    public init(
        _ type: OnboardingPrimaryButtonType = .primary,
        title: LocalizedStringResource? = nil,
        state: OnboardingFlowState<Page>
    ) {
        self.type = type
        self.title = title
        self.state = state
    }

    private let type: OnboardingPrimaryButtonType
    private let title: LocalizedStringResource?

    @Bindable var state: OnboardingFlowState<Page>

    @Environment(\.dismiss) var dismiss

    var fallbackTitle: LocalizedStringResource {
        state.isCurrentPageLast ? .onboardingButtonDone : .onboardingButtonNext
    }

    public var body: some View {
        OnboardingPrimaryButton(type) {
            withAnimation {
                state.showNextPage(orDismiss: dismiss)
            }
        } label: {
            Text(title ?? fallbackTitle)
        }
    }
}

public struct OnboardingSettingsButton: View {

    public init(
        _ type: OnboardingPrimaryButtonType = .primary,
    ) {
        self.type = type
    }

    private let type: OnboardingPrimaryButtonType

    @Environment(\.openURL) var openURL

    public var body: some View {
        if let url = URL.systemSettings {
            OnboardingPrimaryButton(type) {
                openURL(url)
            } label: {
                Text(.onboardingButtonOpenSettings)
            }
        }
    }
}

public struct OnboardingTryButtons<Page>: View {

    public init(
        glassEffect: Bool = false,
        state: OnboardingFlowState<Page>,
        tryAction: @escaping () -> Void
    ) {
        self.glassEffect = glassEffect
        self.state = state
        self.tryAction = tryAction
    }

    private let glassEffect: Bool
    private let tryAction: () -> Void

    @Bindable var state: OnboardingFlowState<Page>

    @Environment(\.dismiss) var dismiss

    public var body: some View {
        HStack {
            OnboardingNextPageOrDismissButton(
                glassEffect ? .secondaryGlass : .secondary,
                title: .onboardingButtonTryLater,
                state: state
            )
            OnboardingPrimaryButton(
                glassEffect ? .primaryGlass : .primary,
                action: tryAction,
                label: { Text(.onboardingButtonTryFree) }
            )
        }
    }
}

private extension OnboardingTryButtons {

    private func nextPageOrDismiss() {
        withAnimation {
            state.showNextPage(orDismiss: dismiss)
        }
    }
}

#Preview {

    @Previewable @State
    var state = OnboardingFlowState(pages: Array(0...5))

    OnboardingFlowContainer(
        pages: state.pages,
        pageIndex: $state.currentPageIndex,
        content: {
            OnboardingPageView(
                pages: state.pages,
                pageIndex: $state.currentPageIndex,
                content: {
                    KankodaOnboardingPage(
                        info: $0,
                        title: "Preview.Title",
                        text: "Preview.Text",
                        image: Image(systemName: "checkmark")
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .symbolVariant(.circle.fill)
                            .symbolRenderingMode(.palette)
                            .foregroundStyle(.red, .green)
                    )
                }
            )
        },
        buttons: { _ in
            VStack {
                OnboardingSettingsButton(.secondary)
                OnboardingTryButtons(state: state) { print("Try") }
                OnboardingTryButtons(glassEffect: true, state: state) { print("Try") }
                OnboardingNextPageOrDismissButton(state: state)
            }

        }
    )
}

#if os(iOS) || os(tvOS) || os(visionOS)
import UIKit
#endif

private extension URL {

    /// This URL will deep link to the app's custom settings
    /// in System Settings.
    ///
    /// The URL's behavior is inconsistent. It should always
    /// link to the app's custom settings in System Settings,
    /// but can sometimes just link to the root instead. The
    /// reason for this behavior is currently unknown.
    ///
    /// To improve this link behavior, add an empty Settings
    /// Bundle to your app. This will causes the app to more
    /// consistently open the correct System Settings screen.
    ///
    /// Maybe `appSettings` would be a better name, but this
    /// name was used to reduce the risk of naming conflicts
    /// with other URL extensions.
    static var systemSettings: URL? {
        #if os(iOS) || os(tvOS) || os(visionOS)
        URL(string: UIApplication.openSettingsURLString)
        #else
        nil
        #endif
    }
}
