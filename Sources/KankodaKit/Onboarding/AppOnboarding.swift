//
//  AppOnboarding.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
//

#if os(iOS) || os(macOS)
import OnboardingKit
import SwiftUI

/// This protocol can be implemented by any type that can be
/// used in an app onboarding.
public protocol AppOnboardingPage {
    
    var title: String { get }
    var text: String { get }
    var image: Image { get }
}

/// This view render an Kankoda onboarding.
public struct AppOnboarding<Page: AppOnboardingPage>: View {
    
    public init(
        _ pages: [Page],
        pageIndex: Binding<Int>
    ) {
        self.pages = pages
        self._pageIndex = pageIndex
    }
    
    private let pages: [Page]
    
    @Binding
    private var pageIndex: Int
    
    @Environment(\.dismiss)
    private var dismiss
    
    public var body: some View {
        OnboardingPageView(
            pages: pages,
            pageIndex: $pageIndex
        ) { page, info in
            VStack(spacing: 25) {
                page.image
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 320)
                    .scaleEffect(info.isCurrentPage ? 1 : 0.9)
                Text(page.title)
                    .font(.title)
                Text(page.text)
                
                if !isLastPage {
                    nextButton
                } else {
                    doneButton
                }
            }
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)
        }
    }
}

private extension AppOnboarding {
    
    var isLastPage: Bool {
        pageIndex == pages.count - 1
    }
}

private extension AppOnboarding {
    
    var doneButton: some View {
        Button {
            dismiss()
        } label: {
            LocalizedText("Tutorial.Done")
        }
        .tutorialButton()
    }
    
    var nextButton: some View {
        Button {
            withAnimation {
                pageIndex += 1
            }
        } label: {
            LocalizedText("Tutorial.Next")
        }
        .tutorialButton()
    }
}

private extension View {
    
    func tutorialButton() -> some View {
        self.buttonStyle(.borderedProminent)
            .controlSize(.regular)
            .padding()
    }
}


private enum TestType: Int, CaseIterable, AppOnboardingPage {
    
    case page1 = 1, page2 = 2
    
    var title: String { "Page \(rawValue)" }
    var text: String { "Text \(rawValue)" }
    var image: Image { .symbol("\(rawValue).circle") }
}

#Preview {
    
    struct Preview: View {
        
        @State private var index = 0
        
        var body: some View {
            AppOnboarding(TestType.allCases, pageIndex: $index)
        }
    }
    
    return Preview()
}
#endif
