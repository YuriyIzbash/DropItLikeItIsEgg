//
//  MainBtn.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct MainButtonStyle {
    let height: CGFloat
    let fontSize: CGFloat
    let horizontalPadding: CGFloat
    let verticalPadding: CGFloat
    
    static let large = MainButtonStyle(
        height: 140,
        fontSize: 56,
        horizontalPadding: 32,
        verticalPadding: 0
    )
    
    static let small = MainButtonStyle(
        height: 100,
        fontSize: 24,
        horizontalPadding: 24,
        verticalPadding: 8
    )
}

struct MainBtn: View {
    enum Size {
        case large
        case small
        
        var style: MainButtonStyle {
            switch self {
            case .large: return .large
            case .small: return .small
            }
        }
    }
    
    let title: String
    let size: Size
    let enableHaptics: Bool
    let action: () -> Void
    
    @State private var isPressed = false
    
    init(
        title: String,
        size: Size = .large,
        enableHaptics: Bool = false,
        action: @escaping () -> Void
    ) {
        self.title = title
        self.size = size
        self.enableHaptics = enableHaptics
        self.action = action
    }
    
    var body: some View {
        Button(action: performAction) {
            Image(.btnMain)
                .resizable()
                .scaledToFit()
                .frame(height: size.style.height)
                .overlay(content: titleView)
                .scaleEffect(isPressed ? 0.97 : 1)
                .rotation3DEffect(
                    .degrees(isPressed ? 2 : 0),
                    axis: (x: 1, y: 0, z: 0),
                    perspective: 0.6
                )
                .offset(y: isPressed ? 1 : 0)
                .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
        }
        .buttonStyle(PressFeedbackStyle(isPressed: $isPressed))
    }
    
    private func titleView() -> some View {
        Text(title)
            .textOutline(width: 1, color: .appTextOutline)
            .customFont(size: size.style.fontSize)
            .multilineTextAlignment(.center)
            .lineLimit(2)
            .minimumScaleFactor(0.5)
            .padding(.horizontal, size.style.horizontalPadding)
            .padding(.vertical, size.style.verticalPadding)
    }
}

struct PressFeedbackStyle: ButtonStyle {
    @Binding var isPressed: Bool
    
    func makeBody(configuration: Configuration) -> some View {
        Group {
            configuration.label
                .onChange(of: configuration.isPressed) { newValue
                    in isPressed = newValue }
        }
    }
}

private extension MainBtn {
    
    func performAction() {
        if enableHaptics {
            UIImpactFeedbackGenerator(style: .light).impactOccurred()
        }
        action()
    }
}

private extension MainBtn {
    
    init(
        title: String,
        size: Size,
        action: @escaping () -> Void
    ) {
        self.init(
            title: title,
            size: size,
            enableHaptics: false,
            action: action
        )
    }
}


#Preview {
    VStack(spacing: 24) {
        MainBtn(title: "LARGE", action: {})
        MainBtn(title: "LARGE button with long text", action: {})
        MainBtn(title: "SMALL", size: .small, action: {})
        MainBtn(title: "SMALL button with long text", size: .small, action: {})
    }
    .padding()
}
