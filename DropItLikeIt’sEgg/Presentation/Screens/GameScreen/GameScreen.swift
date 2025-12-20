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
        ZStackWithBackground(.backgroundGame) {
            
        }
        .overlay(alignment: .top) {
            ZStack(alignment: .trailing) {
                CoinCounterView(amount: 1000)
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
