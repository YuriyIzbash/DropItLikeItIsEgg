//
//  LevelsService.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI
import Combine

@MainActor
final class LevelsService: DefaultsDataSaver<Int>, ObservableObject {
    @Published private(set) var maxUnlockedLevel: Int = 6
    
    init() {
        super.init(key: "levels.maxUnlocked")
        self.maxUnlockedLevel = getValue() ?? 6
    }
    
    func getMaxUnlockedLevel() -> Int? {
        super.getValue()
    }
    
    func saveMaxUnlockedLevel(_ level: Int) {
        super.save(level)
        maxUnlockedLevel = level
    }
}

