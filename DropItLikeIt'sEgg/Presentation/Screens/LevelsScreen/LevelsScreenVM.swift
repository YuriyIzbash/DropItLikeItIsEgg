//
//  LevelsScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import Foundation
import Combine

@MainActor
final class LevelsScreenVM: ObservableObject {
    @Published var coinAmount: Int = 1000
    @Published var levels: [LevelData] = []
    
    private let appVM: ContentVM
    
    init(appVM: ContentVM) {
        self.appVM = appVM
    }
    
    func load() {
        // Unlock all 6 levels for now (can add unlock logic later based on progress)
        levels = (1...6).map { number in
            LevelData(number: number, isLocked: false)
        }
    }
    
    func openGame(for level: Int) {
        appVM.openGame(level: level)
    }
}

struct LevelData: Identifiable {
    let id = UUID()
    let number: Int
    let isLocked: Bool
}

