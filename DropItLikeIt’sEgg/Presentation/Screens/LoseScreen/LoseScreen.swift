//
//  LoseScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 10. 1. 26.
//

import SwiftUI

struct LoseScreen: View {
    @StateObject var vm: LoseScreenVM
    
    let score: Int
    let best: Int
    
    init(score: Int, best: Int, vm: LoseScreenVM) {
        self.score = score
        self.best = best
        _vm = StateObject(wrappedValue: vm)
    }
    
    var body: some View {
        ZStackWithBackground(color: .black.opacity(0.8)) {
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    Text("YOU LOSE!")
                        .customFont(size: 48)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    
                    VStack {
                        ScoreRow(title: "SCORE", value: "\(score)")
                        ScoreRow(title: "BEST", value: "\(best)")
                    }
                    
                    Button {
                        vm.popToRoot()
                    } label: {
                        Text("HOME")
                            .customFont(size: 24)
                            .underline(true)
                    }
                    .padding(.horizontal, 12)
                    .padding(.bottom, 32)
                }
                .padding(.horizontal, 32)
                
                MainBtn(title: "TRY AGAIN", action: {
                    vm.restartLevel()
                })
                .padding(.horizontal, 56)
                .padding(.bottom, 48)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    LoseScreen(score: 500, best: 1200, vm: .init(services: Services.shared, currentLevel: 1))
        .environmentObject(ContentVM(Services.shared))
}
