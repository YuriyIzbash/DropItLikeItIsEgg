//
//  PauseView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct PauseView: View {
    @Binding var isPresented: Bool
    
    var body: some View {
        ZStack {
            Text("paused")
                .customFont(size: 32)
                .padding(.bottom, 160)

            HStack {
                Button {
                    print("Home tapped ...")
                } label: {
                    Text("HOME")
                        .customFont(size: 24)
                        .underline(true)
                }

                Spacer()

                Button {
                    print("Restart tapped ...")
                } label: {
                    Text("RESTART")
                        .customFont(size: 24)
                        .underline(true)
                }
            }

            MainBtn(title: "PLAY", action: {
                isPresented = false
            })
            .frame(maxHeight: .infinity, alignment: .bottom)
            .padding(.bottom, 48)
            .padding(.horizontal, 24)
        }
        .padding(.horizontal, 48)
        .background(Color.black.opacity(0.8))
        .ignoresSafeArea()
    }
}

#Preview {
    PauseView(isPresented: .constant(true))
}
