//
//  ResultScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by Assistant on 11. 1. 26.
//

import Combine

enum GameOutcome {
    case win
    case lose
}

@MainActor
final class ResultScreenVM: BaseModel {
    @Published private(set) var maxUnlockedLevel: Int
    
    let currentLevel: Int
    let outcome: GameOutcome
    
    init(services: Services, currentLevel: Int, outcome: GameOutcome) {
        self.currentLevel = currentLevel
        self.outcome = outcome
        self.maxUnlockedLevel = services.levelsService.maxUnlockedLevel
        super.init(services)
        
        levelsService.$maxUnlockedLevel.assign(to: &$maxUnlockedLevel)
    }
    
    func goHome() {
        popToRoot()
    }
    
    func restartLevel() {
        push(.game(level: currentLevel))
    }
    
    func nextAction() {
        if let nextLevel = gameProgressionService.nextLevel(after: currentLevel) {
            push(.game(level: nextLevel))
        } else if gameProgressionService.isFinalLevel(currentLevel) {
            push(.endGame)
        } else {
            push(.shop)
        }
    }
    
    func openShop() {
        push(.shop)
    }
}
