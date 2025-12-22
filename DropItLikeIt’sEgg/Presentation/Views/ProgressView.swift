//
//  ProgressView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct ProgressView: View {
    @State private var progress: CGFloat = 0
    @State private var isAnimating = false
    @State private var showHome = false
    
    private let barSize = CGSize(width: 340, height: 50)
    private let barCornerRadius: CGFloat = 12
    private let animationDurations = (
        firstPhase: 1.5,
        secondPhase: 2.5,
        finalPhase: 0.8,
        transition: 0.35
    )
    
    // MARK: - Body
    var body: some View {
        ZStack {
            if showHome {
                HomeScreen()
                    .transition(.opacity)
            } else {
                loadingContent
            }
        }
    }
    
    // MARK: - Loading Content
    private var loadingContent: some View {
        ZStackWithBackground {
            GeometryReader { proxy in
                chickenImage(for: proxy)
            }
            .overlay(alignment: .bottom) {
                progressBar
                    .padding(.bottom, 48)
            }
            .onAppear(perform: startProgressAnimation)
            .transition(.opacity)
        }
    }
    
    // MARK: - Components
    private func chickenImage(for proxy: GeometryProxy) -> some View {
        Image(.chicken1)
            .resizable()
            .scaledToFit()
            .frame(width: proxy.size.width, height: proxy.size.height, alignment: .bottom)
    }
    
    private var progressBar: some View {
        ZStack(alignment: .leading) {
            progressBarBackground
            
            progressBarFill
            
            progressBarBorder
            
            progressBarText
        }
        .frame(width: barSize.width, height: barSize.height)
    }
    
    private var progressBarBackground: some View {
        RoundedRectangle(cornerRadius: barCornerRadius)
            .fill(Color.white.opacity(0.95))
    }
    
    private var progressBarFill: some View {
        RoundedRectangle(cornerRadius: barCornerRadius)
            .fill(
                LinearGradient(
                    colors: [Color.appOrange, Color.appYellow],
                    startPoint: .leading,
                    endPoint: .trailing
                )
            )
            .frame(width: barSize.width * max(0, min(progress, 1)))
            .clipShape(RoundedRectangle(cornerRadius: barCornerRadius))
    }
    
    private var progressBarBorder: some View {
        RoundedRectangle(cornerRadius: barCornerRadius)
            .stroke(
                LinearGradient(
                    colors: [Color.appOrange, Color.appYellow],
                    startPoint: .top,
                    endPoint: .bottom
                ),
                lineWidth: 2
            )
    }
    
    private var progressBarText: some View {
        Text("\(Int(progress * 100))%")
            .textOutline(width: 1, color: .appTextOutline)
            .customFont(size: 24)
            .frame(width: barSize.width)
    }
    
    // MARK: - Animation
    private func startProgressAnimation() {
        guard !isAnimating else { return }
        
        isAnimating = true
        progress = 0
        
        //0% -> 34%
        withAnimation(.easeInOut(duration: animationDurations.firstPhase)) {
            progress = 0.34
        }
        
        //34% -> 72%
        withAnimation(.easeInOut(duration: animationDurations.secondPhase)) {
            progress = 0.72
        }
        
        //72% -> 100%
        Task {
            await Task.sleep(seconds: 2.5)
            withAnimation(.easeIn(duration: animationDurations.finalPhase)) {
                progress = 1.0
            }
            
            await Task.sleep(seconds: animationDurations.finalPhase)
            withAnimation(.easeInOut(duration: animationDurations.transition)) {
                showHome = true
            }
        }
    }
}

extension Task where Success == Never, Failure == Never {
    static func sleep(seconds: Double) async {
        try? await Task.sleep(nanoseconds: UInt64(seconds * 1_000_000_000))
    }
}

#Preview {
    ProgressView()
}
