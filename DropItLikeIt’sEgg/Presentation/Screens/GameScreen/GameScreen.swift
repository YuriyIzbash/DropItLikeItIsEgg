//
//  GameScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct GameScreen: View {
    @StateObject var vm: GameScreenVM
    
    var body: some View {
        Color.clear
            .background(
                Image("backgroundGame")
                    .resizable()
                    .scaledToFill()
                    .ignoresSafeArea()
            )
            .overlay(alignment: .top) {
                ZStack(alignment: .trailing) {
                    ZStack(alignment: .leading) {
                        Image(.coinCounter)
                            .resizable()
                            .scaledToFit()
                            .frame(width: 100)
                        
                        Text("1000")
                            .customFont(size: 12)
                            .padding(.leading, 8)
                    }
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    NavBtn(type: .pause) {
                        vm.pause()
                    }
                }
                .padding(.horizontal, 32)
            }
            .overlay {
                if vm.isPaused {
                    PauseView(isPresented: $vm.isPaused)
                        .transition(.opacity)
                        .animation(.easeInOut, value: vm.isPaused)
                }
            }
    }
}

#Preview {
    GameScreen(vm: GameScreenVM())
}
