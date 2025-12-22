//
//  GridLevels.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI

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
                        }
                    }
                }
            }
        }
    }
}
