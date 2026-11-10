//
//  KankodaOnboardingButtons.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025-2026 Kankoda. All rights reserved.
//

import OnboardingKit
import SwiftUI

@available(*, deprecated, renamed: "OnboardingNextButton")
public struct OnboardingNextPageOrDismissButton<Page>: View {

    public init(
        _ type: OnboardingButtonType = .primary,
        title: LocalizedStringResource? = nil,
        state: OnboardingPageState<Page>
    ) {
        self.type = type
        self.title = title
        self.state = state
    }

    private let type: OnboardingButtonType
    private let title: LocalizedStringResource?

    @Bindable var state: OnboardingPageState<Page>

    @Environment(\.dismiss) var dismiss

    var fallbackTitle: LocalizedStringResource {
        state.isLastPage ? .onboardingButtonDone : .onboardingButtonNext
    }

    public var body: some View {
        OnboardingButton(type) {
            withAnimation {
                state.showNextPage(orDismiss: dismiss)
            }
        } label: {
            Text(title ?? fallbackTitle)
        }
    }
}

@available(*, deprecated, renamed: "OnboardingActionButtonGroup")
public struct OnboardingTryButtons<Page>: View {

    public init(
        glassEffect: Bool = false,
        state: OnboardingPageState<Page>,
        tryAction: @escaping () -> Void
    ) {
        self.glassEffect = glassEffect
        self.state = state
        self.tryAction = tryAction
    }

    private let glassEffect: Bool
    private let tryAction: () -> Void

    @Bindable var state: OnboardingPageState<Page>

    @Environment(\.dismiss) var dismiss

    public var body: some View {
        HStack {
            OnboardingNextPageOrDismissButton(
                glassEffect ? .secondaryGlass : .secondary,
                title: .onboardingButtonTryLater,
                state: state
            )
            OnboardingButton(
                glassEffect ? .primaryGlass : .primary,
                action: tryAction,
                label: { Text(.onboardingButtonTryFree) }
            )
        }
    }
    
    private func nextPageOrDismiss() {
        withAnimation {
            state.showNextPage(orDismiss: dismiss)
        }
    }
}
