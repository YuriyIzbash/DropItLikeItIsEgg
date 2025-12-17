//
//  SquareBtn.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct SquareBtn: View {
    let type: SquareBtnType
    var size: CGFloat = 72
    let action: () -> Void
    @State private var isPressed = false
    
    var body: some View {
        Button {
            action()
        } label: {
            Image(type.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
                .shadow(color: Color.black.opacity(isPressed ? 0.15 : 0.35),
                        radius: isPressed ? 6 : 16,
                        x: 0,
                        y: isPressed ? 2 : 8)
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

extension SquareBtn {
    enum SquareBtnType: String, CaseIterable {
        case info
        case menu
        case pause
        case back
        case empty
        
        var imageName: String {
            switch self {
            case .info: "btnInfo"
            case .menu: "btnMenu"
            case .pause: "btnPause"
            case .back: "btnBack"
            case .empty: "btnSquare"
            }
        }
    }
}

#Preview {
    SquareBtn(type: .info) {
        print("Info tapped")
    }
    
    SquareBtn(type: .menu) {
        print("Menu tapped")
    }
    
    SquareBtn(type: .pause) {
        print("Pause tapped")
    }
    
    SquareBtn(type: .back) {
        print("Back tapped")
    }
    SquareBtn(type: .empty) {
        print("Empty btn tapped")
    }
}
