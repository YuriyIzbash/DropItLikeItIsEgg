//
//  BaseModel.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI
import Combine
import os

@MainActor
class BaseModel: ObservableObject, Loggerable {
    @Published var score: Int = 0
    
    let settingsService: SettingsService
    let fileService: FileService
    let userProfileService: UserProfileService
    let leaderboardService: LeaderboardService
    let levelsService: LevelsService
    let dailyBonusService: DailyBonusService
    let shopService: ShopService
    let gameProgressionService: GameProgressionService
    let coordinator: Coordinator
    
    init(_ services: Services) {
        self.settingsService = services.settingsService
        self.fileService = services.fileService
        self.userProfileService = services.userProfileService
        self.leaderboardService = services.leaderboardService
        self.levelsService = services.levelsService
        self.dailyBonusService = services.dailyBonusService
        self.shopService = services.shopService
        self.gameProgressionService = services.gameProgressionService
        
        self.coordinator = services.coordinator
        
        userProfileService.$profile
            .map(\.score)
            .removeDuplicates()
            .assign(to: &self.$score)
    }
    
    func push(_ route: AppRoute) {
        coordinator.push(route)
    }
    
    func popToRoot() {
        coordinator.popToRoot()
    }
}

