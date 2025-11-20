//
//  KankodaOnboardingButtons.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025 Kankoda. All rights reserved.
//

import OnboardingKit
import SwiftUI

/// This is a next page or dismiss button.
public struct OnboardingNextPageOrDismissButton<Page>: View {

    public init(
        state: OnboardingFlowState<Page>
    ) {
        self.state = state
    }

    @Bindable var state: OnboardingFlowState<Page>

    @Environment(\.dismiss) var dismiss

    public var body: some View {
        OnboardingPrimaryButton(
            state.isCurrentPageLast ? "Button.Onboarding.Done" : "Button.Onboarding.Next",
            bundle: .module,
            action: nextPageOrDismiss
        )
    }

    private func nextPageOrDismiss() {
        withAnimation {
            state.showNextPage(orDismiss: dismiss)
        }
    }
}

/// This is a try button.
public struct OnboardingTryButton: View {

    public init(_ action: @escaping () -> Void) {
        self.action = action
    }

    private let action: () -> Void

    public var body: some View {
        OnboardingPrimaryButton(
            "Button.Onboarding.Try",
            bundle: .module,
            action: action
        )
    }
}

/// This is a try later button.
public struct OnboardingTryLaterButton<Page>: View {

    public init(
        state: OnboardingFlowState<Page>
    ) {
        self.state = state
    }

    @Bindable var state: OnboardingFlowState<Page>

    @Environment(\.dismiss) var dismiss

    public var body: some View {
        OnboardingPrimaryButton(
            "Button.Onboarding.TryLater",
            bundle: .module,
            type: .secondary,
            action: nextPageOrDismiss
        )
    }

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
            OnboardingNextPageOrDismissButton(state: state)
        }
    )
}
