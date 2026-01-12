//
//  ContentVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import SwiftUI
import Combine
import os

@MainActor
final class ContentVM: BaseModel {
    @Published private(set) var currentLevel: Int = 1
    @Published private(set) var maxUnlockedLevel: Int = 6
    @Published var isProgressVisible: Bool = true
    
    var profile: UserProfile {
        userProfileService.profile
    }
    
    override init(_ services: Services) {
        super.init(services)
        
        loadLevels()
        checkAndApplyDailyBonus()
        levelsService.$maxUnlockedLevel
            .assign(to: &$maxUnlockedLevel)
    }
    
    func openInfo() {
        push(.info)
    }
    
    func openMenu() {
        push(.menu)
    }
    
    func openLevels() {
        push(.levels)
    }
    
    func hideProgress() {
        isProgressVisible = false
    }
    
    // MARK: - Levels persistence
    func loadLevels() {
        if let stored = levelsService.getMaxUnlockedLevel() {
            maxUnlockedLevel = stored
        }
    }
    
    func unlockLevels(upTo level: Int) {
        if level > maxUnlockedLevel {
            maxUnlockedLevel = level
            levelsService.saveMaxUnlockedLevel(level)
        }
    }
    
    // MARK: - Daily Bonus
    // TODO: - Add Notification Later
    func checkAndApplyDailyBonus() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastBonusDate = dailyBonusService.getLastBonusDate() {
            let lastBonusDay = calendar.startOfDay(for: lastBonusDate)
            
            
            if today > lastBonusDay {
                addCoins(1000)
                dailyBonusService.saveLastBonusDate(today)
                logger.log("Daily bonus applied: 1000 coins")
            } else {
                logger.log("Daily bonus already claimed today")
            }
        } else {
            dailyBonusService.saveLastBonusDate(today)
            logger.log("First launch - daily bonus tracking started")
        }
    }
    
    // MARK: - Profile mutations
    func incrementCounter(by amount: Int = 1) {
        userProfileService.profile.score += amount
    }
    
    func addCoins(_ amount: Int) {
        incrementCounter(by: amount)
    }
}

