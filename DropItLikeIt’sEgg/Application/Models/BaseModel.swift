//
//  BaseModel.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI
import Combine

@MainActor
class BaseModel: ObservableObject {
    let settingsService: SettingsService
    let fileService: FileService
    let userProfileService: UserProfileService
    let leaderboardService: LeaderboardService
    let levelsService: LevelsService
    let dailyBonusService: DailyBonusService
    let shopService: ShopService
    let coordinator: Coordinator
    
    init(_ services: Services) {
        self.settingsService = services.settingsService
        self.fileService = services.fileService
        self.userProfileService = services.userProfileService
        self.leaderboardService = services.leaderboardService
        self.levelsService = services.levelsService
        self.dailyBonusService = services.dailyBonusService
        self.shopService = services.shopService
        
        self.coordinator = services.coordinator
    }
    
    func push(_ route: AppRoute) {
        coordinator.push(route)
    }
    
    func popToRoot() {
        coordinator.popToRoot()
    }
}
