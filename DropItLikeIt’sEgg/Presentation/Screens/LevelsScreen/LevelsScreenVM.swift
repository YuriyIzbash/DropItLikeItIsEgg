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
    var coinAmount: Int {
        userProfileService.profile.score
    }
    
    @Published private(set) var levels: [LevelData] = []
    @Published private(set) var maxUnlockedLevel: Int = 6
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(_ services: Services) {
        self.levels = (1...9).map { number in
            LevelData(number: number, isLocked: true)
        }
        super.init(services)
        
        userProfileService.$profile
            .map { $0.score }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.updateLevels()
            }
            .store(in: &cancellables)
        
        updateLevels()
    }
    
    private func updateLevels() {
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

