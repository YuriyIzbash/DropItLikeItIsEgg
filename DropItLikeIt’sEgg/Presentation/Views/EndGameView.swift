//
//  EndGameView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import SwiftUI

struct EndGameView: View {
    
    var body: some View {
        ZStackWithBackground(.backgroundWin) {
            MainBtn(title: "HOME", size: .large, enableHaptics: true) {
                Coordinator.shared.popToRoot()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    EndGameView()
}
