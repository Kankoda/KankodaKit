//
//  TutorialScreenContent.swift
//  KankodaKit
//
//  Created by Daniel Saidi on 2023-08-25.
//  Copyright © 2023 Daniel Saidi. All rights reserved.
//

#if os(iOS)
import OnboardingKit
import SwiftUI

/**
 This view renders screen content for Kankoda app tutorials.
 */
public struct TutorialScreenContent: View {
    
    public init(
        _ tutorial: LocalizedTutorial,
        pageIndex: Binding<Int>,
        style: TutorialPageViewStyle = .standard
    ) {
        self.tutorial = tutorial
        self._pageIndex = pageIndex
        self.style = style
    }
    
    private let tutorial: LocalizedTutorial
    private let style: TutorialPageViewStyle
    
    @Binding
    private var pageIndex: Int
    
    @State
    private var activePageIndex = 0
    
    @State
    private var animationTrigger = 0
    
    @Environment(\.dismiss)
    private var dismiss
    
    public var body: some View {
        TutorialPageView(
            tutorial: tutorial,
            pageIndex: $pageIndex,
            style: style
        ) { page, info in
            VStack(spacing: 25) {
                Image(page.imageName ?? "")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(maxWidth: 320)
                    .scaleEffect(info.isCurrentPage ? 1 : 0.9)
                Text(page.title)
                    .font(.title)
                Text(page.text)
                Button("Done") {
                    dismiss.callAsFunction()
                }
                .opacity(isLastPage ? 1 : 0)
                .buttonStyle(.borderedProminent)
                .controlSize(.regular)
                .padding()
            }
            .padding()
            .multilineTextAlignment(.center)
            .frame(maxWidth: 500)
        }
        .onChange(of: pageIndex) { newValue in
            withAnimation {
                animationTrigger = newValue
            }
        }
    }
}

private extension TutorialScreenContent {

    var isLastPage: Bool {
        pageIndex == tutorial.pages.count - 1
    }
}
#endif
