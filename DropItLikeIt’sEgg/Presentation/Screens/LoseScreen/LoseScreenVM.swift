//
//  LoseScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 10. 1. 26.
//

import Combine

@MainActor
final class LoseScreenVM: BaseModel {
    @Published private(set) var maxUnlockedLevel: Int
    
    let currentLevel: Int
    
    init(services: Services, currentLevel: Int) {
        self.currentLevel = currentLevel
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
        let maxLevel = maxUnlockedLevel > 6 ? 9 : 6
        if currentLevel < maxLevel {
            push(.game(level: currentLevel))
        } else if maxUnlockedLevel > 6 {
//            push(.endGame)
        } else {
            push(.shop)
        }
    }
    
    func openShop() {
        push(.shop)
    }
}

