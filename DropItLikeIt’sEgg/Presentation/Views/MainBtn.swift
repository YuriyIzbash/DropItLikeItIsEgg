//
//  MainBtn.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct MainBtn: View {
    var title: String
    var action: () -> Void
    var enableHaptics: Bool = true
    @State private var isPressed = false
    @State private var isMultiline = false
    
    var body: some View {
        Button {
            if enableHaptics {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            action()
        } label: {
            HStack {
                Text(title)
                    .padding(.horizontal, 12)
                    .lineLimit(2)
                    .multilineTextAlignment(.center)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(isMultiline ? .menuBtn : .mainBtn)
                    .minimumScaleFactor(0.6)
                    .textOutline(width: 1, color: .textOutline)
                    .appTextStyle()
                    .background(
                        TextSizeReader(text: title, baseFont: .mainBtn) { isWrapped in
                            if isMultiline != isWrapped {
                                isMultiline = isWrapped
                            }
                        }
                            .allowsHitTesting(false)
                            .accessibilityHidden(true)
                    )
            }
            .padding()
            .frame(height: 248)
            .background(
                ZStack {
                    Image("btnMain")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: Color.black.opacity(isPressed ? 0.15 : 0.35),
                                radius: isPressed ? 6 : 16,
                                x: 0,
                                y: isPressed ? 2 : 8)
                }
            )
            .scaleEffect(isPressed ? 0.97 : 1)
            .rotation3DEffect(.degrees(isPressed ? 2 : 0),
                              axis: (x: 1, y: 0, z: 0),
                              perspective: 0.6)
            .offset(y: isPressed ? 1 : 0)
            .animation(.spring(response: 0.25,
                               dampingFraction: 0.7),
                       value: isPressed)
        }
        .buttonStyle(PressFeedbackStyle(isPressed: $isPressed))
    }
}

struct PressFeedbackStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            if #available(iOS 17.0, *) {
                configuration.label
                    .onChange(of: configuration.isPressed) { _, newValue in
                        isPressed = newValue
                    }
            } else {
                configuration.label
                    .background(
                        GeometryReader { _ in
                            Color.clear
                                .onAppear { isPressed = false }
                        }
                    )
                    .onReceive(NotificationCenter.default.publisher(for: UIApplication.willResignActiveNotification)) { _ in
                        isPressed = false
                    }
            }
        }
    }
}

private struct TextSizeReader: View {
    let text: String
    let baseFont: Font
    let onWrapChange: (Bool) -> Void
    
    @State private var availableWidth: CGFloat = 0
    @State private var singleLineWidth: CGFloat = 0
    
    var body: some View {
        GeometryReader { proxy in
            Color.clear
                .onAppear { updateAvailableWidth(proxy.size.width) }
                .onReceive(NotificationCenter.default.publisher(for: UIDevice.orientationDidChangeNotification)) { _ in
                    updateAvailableWidth(proxy.size.width)
                }
                .overlay(alignment: .topLeading) {
                    Text(text)
                        .font(baseFont)
                        .fixedSize(horizontal: true, vertical: false)
                        .opacity(0)
                        .background(
                            GeometryReader { textProxy in
                                Color.clear
                                    .onAppear {
                                        singleLineWidth = textProxy.size.width
                                        notify()
                                    }
                            }
                        )
                }
        }
        .frame(height: 0)
    }
    
    private func updateAvailableWidth(_ width: CGFloat) {
        if availableWidth != width {
            availableWidth = width
            notify()
        }
    }
    
    private func notify() {
        let wraps = singleLineWidth > max(0, availableWidth)
        onWrapChange(wraps)
    }
}

#Preview {
    VStack(spacing: 24) {
        MainBtn(title: "Test", action: { print("Tested with Haptics...") }, enableHaptics: true)
        
        MainBtn(title: "Test", action: { print("Tested  no Haptics...") }, enableHaptics: false)
    }
    .padding()
}
