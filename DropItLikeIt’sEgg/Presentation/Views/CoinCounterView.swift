//
//  CoinCounterView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import SwiftUI
import Combine

struct CoinCounterView: View {
    let amount: Int
    var isInteractive: Bool = true
    var onTap: (() -> Void)? = nil

    @State private var scale: CGFloat = 1.0
    @State private var shimmerOffset: CGFloat = -180

    private let animationTimer = Timer.publish(every: 3, on: .main, in: .common).autoconnect()

    var body: some View {
        ZStack(alignment: .center) {
            coinWithEffects

            Text("\(amount)")
                .customFont(size: 12)
                .padding(.leading, -56)
        }
        .contentShape(Rectangle())
        .onTapGesture {
            guard isInteractive else { return }
            onTap?()
        }
        .onReceive(animationTimer) { _ in
            guard isInteractive else { return }
            triggerShineAndSpring()
        }
        .onAppear {
            if isInteractive {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.3) {
                    triggerShineAndSpring()
                }
            }
        }
    }

    private var coinWithEffects: some View {
        Image(.coinCounter)
            .resizable()
            .scaledToFit()
            .frame(height: 64)
            .scaleEffect(scale)
            .overlay(alignment: .center) {
                if isInteractive {
                    shimmer
                        .mask(
                            Image(.coinCounter)
                                .resizable()
                                .scaledToFit()
                        )
                        .frame(height: 64)
                }
            }
    }

    private var shimmer: some View {
        LinearGradient(
            colors: [
                .white.opacity(0.0),
                .white.opacity(0.7),
                .white.opacity(0.0)
            ],
            startPoint: .top,
            endPoint: .bottom
        )
        .frame(width: 120)
        .rotationEffect(.degrees(25))
        .offset(x: shimmerOffset)
        .blendMode(.screen)
        .allowsHitTesting(false)
    }

    private func triggerShineAndSpring() {
        shimmerOffset = -180
        withAnimation(.easeInOut(duration: 0.8)) {
            shimmerOffset = 180
        }

        withAnimation(.spring(response: 0.35, dampingFraction: 0.45, blendDuration: 0.1)) {
            scale = 1.08
        }
        
        DispatchQueue.main.asyncAfter(deadline: .now() + 0.22) {
            withAnimation(.spring(response: 0.35, dampingFraction: 0.8, blendDuration: 0.1)) {
                scale = 1.0
            }
        }
    }
}

#Preview {
    CoinCounterView(amount: 1000, isInteractive: true, onTap: { print("Coin tapped") })
}
