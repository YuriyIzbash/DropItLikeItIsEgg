//
//  EndGameView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import SwiftUI

struct EndGameView: View {
    @EnvironmentObject private var appVM: ContentVM
    
    var body: some View {
        ZStackWithBackground(.backgroundWin) {
            MainBtn(title: "HOME", size: .large, enableHaptics: true) {
                appVM.popToRoot()
            }
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 32)
        }
    }
}

#Preview {
    EndGameView()
}
