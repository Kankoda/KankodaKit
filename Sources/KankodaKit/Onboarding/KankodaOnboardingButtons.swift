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

    public init(_ state: OnboardingPageState<Page>) {
        self._state = .init(wrappedValue: state)
    }

    @Environment(\.dismiss) var dismiss

    @ObservedObject var state: OnboardingPageState<Page>

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

public struct OnboardingTryLaterButton<Page>: View {

    public init(_ state: OnboardingPageState<Page>) {
        self.state = state
    }

    @Environment(\.dismiss) var dismiss

    private let state: OnboardingPageState<Page>

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

    @Previewable @StateObject
    var state = OnboardingPageState(pages: Array(0...5))

    OnboardingScreen(
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
            Color.red.frame(height: 44)
        }
    )
}
