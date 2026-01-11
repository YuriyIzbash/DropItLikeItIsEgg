import Foundation
import Combine

@MainActor
final class GameProgressionService {
    private let levelsService: LevelsService
    
    init(levelsService: LevelsService) {
        self.levelsService = levelsService
    }

    func maxPlayableLevel() -> Int {
        let unlocked = levelsService.maxUnlockedLevel
        return unlocked > 6 ? 9 : 6
    }
    
    func isFinalLevel(_ level: Int) -> Bool {
        level >= maxPlayableLevel()
    }
    
    func nextLevel(after level: Int) -> Int? {
        let maxLevel = maxPlayableLevel()
        let next = level + 1
        return next <= maxLevel ? next : nil
    }
}
