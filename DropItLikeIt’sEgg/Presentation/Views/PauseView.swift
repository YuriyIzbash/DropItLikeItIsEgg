//
//  PauseView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct PauseView: View {
    @EnvironmentObject private var appVM: ContentVM
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStackWithBackground(color: .black.opacity(0.8)) {
            Text("paused")
                .customFont(size: 32)
                .padding(.bottom, 160)

            HStack {
                Button {
                    appVM.popToRoot()
                } label: {
                    Text("HOME")
                        .customFont(size: 24)
                        .underline(true)
                }

                Spacer()

                Button {
                    appVM.openGame()
                } label: {
                    Text("RESTART")
                        .customFont(size: 24)
                        .underline(true)
                }
            }
            .padding(.horizontal, 48)

            MainBtn(title: "PLAY", action: {
                isPresented = false
            })
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 48)
            .padding(.horizontal, 64)
        }
    }
}

#Preview {
    PauseView(isPresented: .constant(true))
}
