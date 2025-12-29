//
//  ContentVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import SwiftUI
import Combine


final class ContentVM: BaseModel {
    // MARK: - Navigation
    @Published private(set) var currentLevel: Int = 1
    @Published private(set) var maxUnlockedLevel: Int = 6
    
    // MARK: - Shared reactive profile
    struct AppProfile {
        var score: Int = 0
    }
    
    @Published var profile: AppProfile = .init()
    
    override init(_ services: Services) {
        super.init(services)
        loadProfile()
        loadLevels()
        checkAndApplyDailyBonus()
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
    
    // MARK: - Profile persistence
    func loadProfile() {
        if let storedProfile = userProfileService.load() {
            profile.score = storedProfile.score
        } else {
            profile.score = 1000
            saveProfile()
        }
    }
    
    func saveProfile() {
        if var existingProfile = userProfileService.load() {
            existingProfile.score = profile.score
            userProfileService.save(existingProfile)
        } else {
            userProfileService.save(UserProfile(score: profile.score))
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
                print("Daily bonus applied: 1000 coins")
            } else {
                print("Daily bonus already claimed today")
            }
        } else {
            dailyBonusService.saveLastBonusDate(today)
            print("First launch - daily bonus tracking started")
        }
    }
    
    // MARK: - Navigation helpers (Coordinator-based)
    func openInfo() { push(.info) }
    func openMenu() { push(.menu) }
    func openLevels() { push(.levels) }
    func openGame(level: Int) {
        currentLevel = level
        push(.game)
    }
    func openProfile() { push(.profile) }
    func openSettings() { push(.settings) }
    func openLeaderboard() { push(.leaderboard) }
    func openPrivacy() { push(.privacy) }
    func openTerms() { push(.terms) }
    func openShop() { push(.shop) }
    func openEndGame() { push(.endGame) }
    
    // MARK: - Profile mutations
    func incrementCounter(by amount: Int = 1) {
        profile.score += amount
        saveProfile()
    }
    
    func addCoins(_ amount: Int) {
        incrementCounter(by: amount)
    }
}

