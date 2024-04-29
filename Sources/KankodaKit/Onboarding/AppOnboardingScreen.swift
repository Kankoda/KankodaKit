//
//  AppOnboardingScreen.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023-2024 Kankoda. All rights reserved.
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
}

/// This screen can render a Kankoda onboarding.
public struct AppOnboardingScreen<Page: AppOnboardingScreenPage>: View {
    
    public init(_ pages: [Page]) {
        self.pages = pages
    }
    
    private let pages: [Page]
    
    @State
    private var pageIndex = 0
    
    @Environment(\.dismiss)
    private var dismiss
    
    public var body: some View {
        DiagonalContent(diagonalOffset: 225) {
            OnboardingPageView(
                pages: pages,
                pageIndex: $pageIndex
            ) { page, info in
                VStack(spacing: 50) {
                    Spacer()
                    page.image
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                        .frame(width: 280)
                        .scaleEffect(pageIndex == info.pageIndex ? 1 : 0.8)
                        .animation(.bouncy, value: pageIndex)
                        
                    VStack(spacing: 20) {
                        Text(page.title)
                            .font(.title)
                            .forceMultiline()
                        Text(page.text)
                            .forceMultiline()
                    }
                    Spacer()
                    button.padding(.bottom, 40)
                }
                .padding()
                .multilineTextAlignment(.center)
                .frame(maxWidth: 500)
                .frame(maxHeight: .infinity, alignment: .center)
            }
        }
        .toolbar {
            Button(.done, action: dismiss.callAsFunction)
                .labelStyle(.titleOnly)
        }
        .navigationTitle("")
        .navigationBarTitleDisplayMode(.inline)
    }
}

/// This modal screen can render a Kankoda onboarding.
public struct AppOnboardingScreenModal<Page: AppOnboardingScreenPage>: View {
    
    public init(_ pages: [Page]) {
        self.pages = pages
    }
    
    private let pages: [Page]
    
    public var body: some View {
        NavigationStack {
            AppOnboardingScreen(pages)
        }
    }
}

private extension AppOnboardingScreen {
    
    var isLastPage: Bool {
        pageIndex == pages.count - 1
    }
}

private extension AppOnboardingScreen {
    
    @ViewBuilder
    var button: some View {
        if !isLastPage {
            nextButton
        } else {
            doneButton
        }
    }
    
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


private enum TestType: Int, AppOnboardingScreenPage, CaseIterable {
    
    case page1 = 1, page2 = 2
    
    var title: String { "Page \(rawValue)" }
    var text: String { "Text \(rawValue)" }
    var image: Image { .symbol("\(rawValue).circle") }
}

#Preview {
    
    struct Preview: View {
        
        @State private var index = 0
        
        var body: some View {
            AppOnboardingScreenModal(
                TestType.allCases
            )
        }
    }
    
    return Preview()
}
#endif
