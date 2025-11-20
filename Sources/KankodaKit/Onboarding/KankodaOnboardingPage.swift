//
//  KankodaOnboardingPage.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025 Kankoda. All rights reserved.
//

import OnboardingKit
import SwiftUI

/// This is a standard onboarding page view.
public struct KankodaOnboardingPage<Page, ImageView: View>: View {

    public init(
        info: OnboardingFlowPage<Page>,
        title: LocalizedStringKey,
        text: LocalizedStringKey,
        image: ImageView
    ) {
        self.info = info
        self.title = title
        self.text = text
        self.image = image
    }

    private let info: OnboardingFlowPage<Page>
    private let title: LocalizedStringKey
    private let text: LocalizedStringKey
    private let image: ImageView

    @State var isCurrent = true

    public var body: some View {
        OnboardingFlowContainerCenteredContent {
            VStack(spacing: 50) {
                Spacer()
                image
                VStack(spacing: 20) {
                    Text(title)
                        .font(.title)
                        .forceMultiline()
                    Text(text)
                        .forceMultiline()
                }
                Spacer()
            }
            .scaleEffect(isCurrent ? 1 : 0.5)
            .padding()
            .onChange(of: info.currentPageIndex) { _, newValue in
                withAnimation(.bouncy) {
                    let isCurrent = newValue == info.pageIndex
                    guard isCurrent != self.isCurrent else { return }
                    self.isCurrent = isCurrent
                }
            }
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
            Color.red.frame(height: 44)
        }
    )
}
