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
        levels = (1...9).map { number in
            LevelData(number: number, isLocked: number >= 7)
        }
    }
    
    func openGame(for level: Int) {
        appVM.openGame()
    }
}

struct LevelData: Identifiable {
    let id = UUID()
    let number: Int
    let isLocked: Bool
}
