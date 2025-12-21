//
//  LevelsScreen.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct LevelsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: LevelsScreenVM
    
    var body: some View {
        ZStackWithBackground {
                VStack {
                    HStack {
                        NavBtn(type: .back) { dismiss() }
                        
                        Spacer()
                        
                        CoinCounterView(amount: vm.coinAmount)
                    }
                    
                    Text("CHANGE LEVEL")
                        .customFont(size: 32)
                        .lineLimit(1)
                        .padding(.top, 16)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 48)
            
            GridLevels(vm: vm)
            .padding(.top, 48)
        }
        .padding(.horizontal, 32)
        .onAppear {
            vm.load()
        }
    }
}

struct GridLevels: View {
    @ObservedObject var vm: LevelsScreenVM
    
    var body: some View {
        Grid(horizontalSpacing: 16, verticalSpacing: 24) {
            ForEach(0..<3, id: \.self) { row in
                GridRow {
                    ForEach(0..<3, id: \.self) { col in
                        let index = row * 3 + col
                        if index < vm.levels.count {
                            let level = vm.levels[index]
                            NavBtn(type: .empty, size: 96) {
                                if !level.isLocked {
                                    vm.openGame(for: level.number)
                                }
                            }
                            .overlay(
                                Text("\(level.number)")
                                    .customFont(size: 32)
                            )
                            .allowsHitTesting(!level.isLocked)
                            .grayscale(level.isLocked ? 1.0 : 0.0)
                        } else {
                            // Empty space for levels beyond available count
                            Color.clear
                                .frame(width: 96, height: 96)
                        }
                    }
                }
            }
        }
    }
}

#Preview {
    LevelsScreen(vm: .init(appVM: ContentVM()))
}

