//
//  AppOnboardingScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2025 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import OnboardingKit
import SwiftUI

/// This protocol can be implemented by any type that can be
/// used as an app onboarding page.
public protocol AppOnboardingScreenPage {
    
    var title: String { get }
    var text: String { get }
    var image: Image { get }

    var pageType: AppOnboarding.PageType { get }
}

/// This screen can render a Kankoda onboarding.
public struct AppOnboardingScreen<Page: AppOnboardingScreenPage, Buttons: View>: View {

    public init(
        _ pages: [Page],
        addDoneButton: Bool = true,
        @ViewBuilder buttons: @escaping (ButtonParams) -> Buttons
    ) {
        self.pages = pages
        self.addDoneButton = addDoneButton
        self.buttons = buttons
    }
    
    private let pages: [Page]
    private let addDoneButton: Bool
    private let buttons: (ButtonParams) -> Buttons

    public typealias ButtonParams = (
        page: Page,
        pageType: AppOnboarding.PageType,
        isLastPage: Bool,
        nextOrDismiss: () -> Void,
        buttons: AppOnboarding.NextButton
    )

    @State var pageIndex = 0
    @State var subscriptionScreenInfo: SubscriptionScreenInfo?

    @Environment(\.dismiss)
    private var dismiss
    
    public var body: some View {
        OnboardingPageView(
            pages: pages,
            pageIndex: $pageIndex
        ) { page, info in
            VStack(spacing: 50) {
                Spacer()
                image(for: page, info: info)
                VStack(spacing: 20) {
                    Text(page.title)
                        .font(.title)
                        .forceMultiline()
                    Text(page.text)
                        .forceMultiline()
                }
                Spacer()
            }
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)
            .frame(maxHeight: .infinity, alignment: .center)
        }
        .background(Color.diagonalForeground)
        .safeAreaInset(edge: .bottom) { buttonsView }
        .toolbar {
            if addDoneButton {
                Button(.done, action: dismiss.callAsFunction)
                    .labelStyle(.titleOnly)
            }
        }
    }
}

private extension AppOnboardingScreen {
    
    var currentPage: Page {
        guard pageIndex < pages.count else { return pages[pages.count - 1] }
        return pages[pageIndex]
    }

    var isLastPage: Bool {
        pageIndex == pages.count - 1
    }

    func nextPage() {
        withAnimation {
            pageIndex += 1
        }
    }

    func nextPageOrDismiss() {
        if isLastPage { return dismiss() }
        nextPage()
    }
}

private extension AppOnboardingScreen {

    var buttonsView: some View {
        buttons((
            page: currentPage,
            pageType: currentPage.pageType,
            isLastPage: isLastPage,
            nextOrDismiss: nextPageOrDismiss,
            buttons: .init(
                isLastPage: isLastPage,
                nextOrDismiss: nextPageOrDismiss
            )
        ))
        .padding([.horizontal, .bottom])
        .animation(.default, value: pageIndex)
    }

    func image(
        for page: Page,
        info: OnboardingPageInfo
    ) -> some View {
        page.image
            .resizable()
            .aspectRatio(contentMode: .fit)
            .frame(width: 280)
            .scaleEffect(pageIndex == info.pageIndex ? 1 : 0.8)
            .animation(.bouncy, value: pageIndex)
    }
}

private enum TestType: Int, AppOnboardingScreenPage, CaseIterable {

    case page1, page2, page3, page4

    var title: String { "Page \(number)" }
    var text: String { "Text \(number)" }
    var image: Image { .symbol("\(number).circle") }

    var number: Int { rawValue + 1 }

    var pageType: AppOnboarding.PageType {
        switch self {
        case .page1: .regular
        case .page2: .regular
        case .page3: .subscriptionUpsell
        case .page4: .regular
        }
    }
}

#Preview {
    
    struct Preview: View {
        
        @State private var index = 0
        
        var body: some View {
            NavigationStack {
                AppOnboardingScreen(
                    TestType.allCases
                ) { params in
                    switch params.pageType {
                    case .regular: params.buttons
                    case .subscriptionUpsell:
                        params.buttons
                        params.buttons
                    }
                }
            }
        }
    }
    
    return Preview()
}
#endif
