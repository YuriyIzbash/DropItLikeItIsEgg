//
//  GameScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct GameScreen: View {
    @State private var isPaused: Bool = false
    
    var body: some View {
        Color.clear
            .edgesIgnoringSafeArea(.all)
            .background(
                ZStack {
                    Image("backgroundGame")
                        .resizable()
                        .scaledToFill()
                    
                }
                    .ignoresSafeArea()
            )
            .overlay(
                ZStack(alignment: .trailing) {
                    ZStack(alignment: .leading) {
                        Image(.coinCounter)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        Text("1000")
                            .font(.coinCounter)
                            .appTextStyle()
                            .padding(.leading, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    NavBtn(type: .pause) {
                        isPaused = true
                    }
                }
                    .padding(.horizontal, 32)
                , alignment: .top
            )
            .overlay {
                if isPaused {
                    PauseView(isPresented: $isPaused)
                        .transition(.opacity)
                        .animation(.easeInOut, value: isPaused)
                }
            }
    }
}

#Preview {
    GameScreen()
}
