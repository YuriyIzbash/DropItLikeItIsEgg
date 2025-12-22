//
//  LevelsService.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation

final class LevelsService: DefaultsDataSaver<Int> {
    init() {
        super.init(key: "levels.maxUnlocked")
    }
    
    func getMaxUnlockedLevel() -> Int? {
        super.getValue()
    }
    
    func saveMaxUnlockedLevel(_ level: Int) {
        super.save(level)
    }
}
