//
//  LevelsScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import Foundation
import Combine

@MainActor
final class LevelsScreenVM: BaseModel {
    @Published private(set) var coinAmount: Int = 1000
    @Published private(set) var levels: [LevelData] = []
    @Published private(set) var maxUnlockedLevel: Int = 6
    
    override init(_ services: Services) {
        self.levels = (1...9).map { number in
            LevelData(number: number, isLocked: true)
        }
        super.init(services)
        
        load()
    }
    
    func load() {
        coinAmount = userProfileService.load()?.score ?? 0
        if let stored = levelsService.getMaxUnlockedLevel() {
            maxUnlockedLevel = stored
        }
        
        let shouldLockAll = coinAmount == 0
        
        levels = (1...9).map { number in
            LevelData(number: number, isLocked: shouldLockAll || number > maxUnlockedLevel)
        }
    }
    
    func openGame(for level: Int) {
        push(.game(level: level))
    }
    
    func openShop() {
        push(.shop)
    }
}

