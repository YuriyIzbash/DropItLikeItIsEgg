//
//  WinScreen.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 11. 1. 26.
//

import SwiftUI

struct WinScreen: View {
    @StateObject var vm: ResultScreenVM
    
    let score: Int
    let best: Int
    
    init(score: Int, best: Int, vm: ResultScreenVM) {
        self.score = score
        self.best = best
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStackWithBackground(color: .black.opacity(0.8)) {
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    Text("YOU WIN!")
                        .customFont(size: 48)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    
                    VStack {
                        ScoreRow(title: "SCORE", value: "\(score)")
                        ScoreRow(title: "BEST", value: "\(best)")
                    }
                    
                    HStack {
                        Button {
                            vm.goHome()
                        } label: {
                            Text("HOME")
                                .customFont(size: 24)
                                .underline(true)
                        }
                        
                        Spacer()
                        
                        Button {
                            vm.restartLevel()
                        } label: {
                            Text("RESTART")
                                .customFont(size: 24)
                                .underline(true)
                        }
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 32)
                
                MainBtn(title: "NEXT", action: vm.nextAction)
                .padding(.horizontal, 48)
                .padding(.bottom, 48)
            }
        }
    }
}

struct ScoreRow: View {
    let title: String
    let value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.appLightGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appGreen, lineWidth: 2)
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 60)
            
            HStack(spacing: 18) {
                Text(title)
                
                Spacer()
                
                Text(value)
            }
            .padding(.horizontal, 18)
            .customFont(size: 24)
        }
    }
}

#Preview {
    WinScreen(score: 1200, best: 1500, vm: ResultScreenVM(services: Services.shared, currentLevel: 1, outcome: GameOutcome.win))
        .environmentObject(ContentVM(Services.shared))
}
