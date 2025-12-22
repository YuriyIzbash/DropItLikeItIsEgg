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
    @Published var coinAmount: Int = 1000
    @Published var levels: [LevelData] = []
    @Published var maxUnlockedLevel: Int = 6
    
    private let appVM: ContentVM
    
    init(appVM: ContentVM, services: Services) {
        self.appVM = appVM
        self.levels = (1...9).map { number in
            LevelData(number: number, isLocked: true)
        }
        super.init(services)
        load()
    }
    
    func load() {
        coinAmount = userProfileService.load()?.score ?? 0
        maxUnlockedLevel = appVM.maxUnlockedLevel
        
        let shouldLockAll = coinAmount == 0
        
        levels = (1...9).map { number in
            LevelData(number: number, isLocked: shouldLockAll || number > maxUnlockedLevel)
        }
    }
    
    func openGame(for level: Int) {
        appVM.openGame(level: level)
    }
    
    func openShop() {
        appVM.openShop()
    }
}

