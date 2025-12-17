//
//  MainBtn.swift
//  DropItLike It’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct MainBtn: View {
    var title: String
    var action: () -> Void
    var enableHaptics: Bool = true
    @State private var isPressed = false

    var body: some View {
        Button {
            if enableHaptics {
                UIImpactFeedbackGenerator(style: .light).impactOccurred()
            }
            action()
        } label: {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.mainBtn)
                    .textOutline(width: 1, color: .textOutline)
                    .foregroundColor(.white)
            }
            .frame(height: 248)
            .background(
                ZStack {
                    Image("btnMain")
                        .resizable()
                        .scaledToFit()
                        .shadow(color: Color.black.opacity(isPressed ? 0.15 : 0.35),
                                radius: isPressed ? 6 : 16, x: 0, y: isPressed ? 2 : 8)
                }
            )
            .scaleEffect(isPressed ? 0.97 : 1)
            .rotation3DEffect(.degrees(isPressed ? 2 : 0), axis: (x: 1, y: 0, z: 0), perspective: 0.6)
            .offset(y: isPressed ? 1 : 0)
            .animation(.spring(response: 0.25, dampingFraction: 0.7), value: isPressed)
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

#Preview {
    VStack(spacing: 24) {
        MainBtn(title: "Test", action: { print("Tested with Haptics...") }, enableHaptics: true)
        MainBtn(title: "Test", action: { print("Tested  no Haptics...") }, enableHaptics: false)
    }
    .padding()
}
