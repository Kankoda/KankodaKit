//
//  AppOnboarding+Screen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import OnboardingKit
import SwiftUI

public extension AppOnboarding {

    /// This screen can render a Kankoda onboarding.
    struct Screen<Page, Content: View, Buttons: View>: View {

        public init(
            pages: [Page],
            pageIndex: Binding<Int>,
            addDoneButton: Bool = true,
            @ViewBuilder content: @escaping (PageParams) -> Content,
            @ViewBuilder buttons: @escaping (ButtonParams) -> Buttons
        ) {
            self.pages = pages
            self._pageIndex = pageIndex
            self.addDoneButton = addDoneButton
            self.content = content
            self.buttons = buttons
        }

        private let pages: [Page]
        private let addDoneButton: Bool
        private let content: (PageParams) -> Content
        private let buttons: (ButtonParams) -> Buttons

        @Binding var pageIndex: Int

        public typealias ButtonParams = (
            isFirstPage: Bool,
            isLastPage: Bool,
            previousPage: () -> Void,
            nextPageOrDismiss: () -> Void
        )

        public typealias PageParams = (
            page: Page,
            info: OnboardingPageInfo,
            previousPage: () -> Void,
            nextPageOrDismiss: () -> Void
        )

        @State var subscriptionScreenInfo: SubscriptionScreenInfo?

        @Environment(\.dismiss)
        private var dismiss

        public var body: some View {
            OnboardingPageView(
                pages: pages,
                pageIndex: $pageIndex
            ) { page, info in
                content(pageParams(for: page, info: info))
                    .padding()
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: 500)
                    .frame(maxHeight: .infinity, alignment: .center)
            }
            .safeAreaInset(edge: .bottom) {
                buttons(buttonParams)
                    .padding([.horizontal, .bottom])
                    .animation(.default, value: pageIndex)
            }
            .toolbar {
                if addDoneButton {
                    Button(.done, action: dismiss.callAsFunction)
                        .labelStyle(.titleOnly)
                }
            }
        }
    }
}

private extension AppOnboarding.Screen {

    var buttonParams: ButtonParams {
        ButtonParams(
            isFirstPage: isCurrentPageFirst,
            isLastPage: isCurrentPageLast,
            previousPage: previousPage,
            nextPageOrDismiss: nextPageOrDismiss
        )
    }

    func pageParams(
        for page: Page,
        info: OnboardingPageInfo
    ) -> PageParams {
        PageParams(
            page: page,
            info: info,
            previousPage: previousPage,
            nextPageOrDismiss: nextPageOrDismiss
        )
    }

    var currentPage: Page {
        let last = pages[pages.count - 1]
        guard pageIndex < pages.count else { return last }
        return pages[pageIndex]
    }

    var hasPreviousPage: Bool { !isCurrentPageFirst }
    var hasNextPage: Bool { !isCurrentPageLast }
    var isCurrentPageFirst: Bool { pageIndex == 0 }
    var isCurrentPageLast: Bool { pageIndex == (pages.count - 1) }

    func previousPage() {
        guard hasPreviousPage else { return }
        pageIndex -= 1
    }

    func nextPageOrDismiss() {
        guard hasNextPage else { return dismiss() }
        pageIndex += 1
    }
}

#Preview {

    struct Preview: View {

        @State var pageIndex = 0

        var body: some View {
            NavigationStack {
                AppOnboarding.Screen(
                    pages: Array(0...10),
                    pageIndex: $pageIndex,
                    content: { params in
                        AppOnboarding.ScreenContent(
                            title: "Preview.Title.\(params.info.pageIndex)",
                            text: "Preview.Text",
                            image: Image(systemName: "\(params.info.pageIndex).circle")
                                .font(.largeTitle)
                                .scaleEffect(params.info.isCurrentPage ? 1 : 0)
                                .animation(.bouncy, value: params.info.isCurrentPage)
                        )
                    }, buttons: { params in
                        AppOnboarding.NextButton(
                            isLastPage: params.isLastPage,
                            nextPageOrDismiss: {
                                withAnimation {
                                    params.nextPageOrDismiss()
                                }
                            }
                        )
                    }
                )
                .background(Color.red)
            }
        }
    }
    
    return Preview()
}
#endif
