//
//  Services.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI

@MainActor
final class Services {
    static let shared = Services()
    
    let settingsService = SettingsService()
    let fileService = FileService.shared
    let userProfileService = UserProfileService()
    let leaderboardService = LeaderboardService.shared
    let levelsService = LevelsService()
    let dailyBonusService = DailyBonusService()
    let shopService = ShopService()
    
    let coordinator = Coordinator.shared
    
    init() {}
}

