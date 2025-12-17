//
//  SquareBtn.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct SquareBtn: View {
    let type: SquareBtnType
    var size: CGFloat = 100
    let action: () -> Void
    
    var body: some View {
        Button(action: action) {
            Image(type.imageName)
                .resizable()
                .scaledToFit()
                .frame(width: size, height: size)
        }
        .buttonStyle(.plain)
    }
}

extension SquareBtn {
    enum SquareBtnType: String, CaseIterable {
        case info
        case menu
        case pause
        case back
        
        var imageName: String {
            switch self {
            case .info:
                return "btnInfo"
            case .menu:
                return "btnMenu"
            case .pause:
                return "btnPause"
            case .back:
                return "btnBack"
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
}
