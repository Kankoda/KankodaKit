//
//  KankodaOnboardingPage.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2025-05-22.
//  Copyright © 2025-2026 Kankoda. All rights reserved.
//

import OnboardingKit
import SwiftUI

/// This is a standard onboarding page view.
public struct KankodaOnboardingPage<Page, ImageView: View>: View {

    public init(
        info: OnboardingPage<Page>,
        title: LocalizedStringResource,
        text: LocalizedStringResource,
        image: ImageView
    ) {
        self.info = info
        self.title = title
        self.text = text
        self.image = image
    }

    private let info: OnboardingPage<Page>
    private let title: LocalizedStringResource
    private let text: LocalizedStringResource
    private let image: ImageView

    @State var isCurrent = true

    public var body: some View {
        OnboardingFlowCenteredContent {
            VStack(spacing: 30) {
                image
                VStack(spacing: 20) {
                    Text(title)
                        .font(.title)
                        .forceMultiline()
                    Text(text)
                        .forceMultiline()
                }
            }
            .scaleEffect(isCurrent ? 1 : 0.5)
            .frame(maxHeight: .infinity, alignment: .center)
            .padding()
            .padding(.bottom, 40)
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

    struct Preview: View {
        @State var isPresented = true
        @State var state = OnboardingFlowState(pages: Array(0...5))

        var body: some View {
            Button("Show Onboarding") {
                isPresented.toggle()
            }
            .sheet(isPresented: $isPresented) {
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
                                    title: "That's it!",
                                    text: """
Thank you for giving KeyboardKit a try. We hope you’ll love using it.

Don’t hesitate to [reach out](mailto:info@keyboardkit.com) if you have any questions or feedback.
""",
                                    image: Image(.Previews.onboardingHeader)
                                        .resizable()
                                        .aspectRatio(contentMode: .fit)
                                )
                            }
                        )
                    },
                    buttons: { _ in
                        Color.red.frame(height: 44)
                    }
                )
            }
            .onboardingIntroScreenStyle(.init(
                iconSize: 150
            ))
        }
    }

    return Preview()
}
