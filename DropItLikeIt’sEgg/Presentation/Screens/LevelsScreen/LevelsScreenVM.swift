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
    @Published var maxUnlockedLevel: Int = 6
    
    private let appVM: ContentVM
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    
    init(appVM: ContentVM) {
        self.appVM = appVM
        // Initialize levels array to prevent index out of range
        self.levels = (1...9).map { number in
            LevelData(number: number, isLocked: true)
        }
    }
    
    func load() {
        coinAmount = profileSaver.getValue()?.score ?? 0
        maxUnlockedLevel = appVM.maxUnlockedLevel
        
        // If score is 0, lock all levels
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
