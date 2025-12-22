//
//  ContentVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import SwiftUI
import Combine

@MainActor
final class ContentVM: ObservableObject {
    // MARK: - Navigation
    @Published var path: [AppRoute] = []
    @Published var currentLevel: Int = 1
    @Published var maxUnlockedLevel: Int = 6

    // MARK: - Shared reactive profile
    struct AppProfile {
        var score: Int = 0
    }

    @Published var profile: AppProfile = .init()

    private let scoreSaver = DefaultsDataSaver<Int>(key: "profile.score")
    private let maxUnlockedSaver = DefaultsDataSaver<Int>(key: "levels.maxUnlocked")
    private let userProfileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    private let lastDailyBonusSaver = DefaultsDataSaver<Date>(key: "user.lastDailyBonus")

    init() {
        loadProfile()
        loadLevels()
        checkAndApplyDailyBonus()
    }

    // MARK: - Levels persistence
    func loadLevels() {
        if let stored = maxUnlockedSaver.getValue() {
            maxUnlockedLevel = stored
        }
    }

    func unlockLevels(upTo level: Int) {
        if level > maxUnlockedLevel {
            maxUnlockedLevel = level
            maxUnlockedSaver.save(level)
        }
    }

    // MARK: - Profile persistence
    func loadProfile() {
        if let storedProfile = userProfileSaver.getValue() {
            profile.score = storedProfile.score
            return
        }
        if let stored = scoreSaver.getValue() {
            profile.score = stored
        } else {
            // First time user - give initial 1000 coins
            profile.score = 1000
            saveProfile()
        }
    }

    func saveProfile() {
        scoreSaver.save(profile.score)
    
        if var existingProfile = userProfileSaver.getValue() {
            existingProfile.score = profile.score
            userProfileSaver.save(existingProfile)
        } else {
            userProfileSaver.save(UserProfile(score: profile.score))
        }
    }
    
    // MARK: - Daily Bonus
    // TODO: - Add Notification Later
    func checkAndApplyDailyBonus() {
        let calendar = Calendar.current
        let today = calendar.startOfDay(for: Date())
        
        if let lastBonusDate = lastDailyBonusSaver.getValue() {
            let lastBonusDay = calendar.startOfDay(for: lastBonusDate)
            
            
            if today > lastBonusDay {
                addCoins(1000)
                lastDailyBonusSaver.save(today)
                print("Daily bonus applied: 1000 coins")
            } else {
                print("Daily bonus already claimed today")
            }
        } else {
            lastDailyBonusSaver.save(today)
            print("First launch - daily bonus tracking started")
        }
    }

    // MARK: - Profile mutations
    func incrementCounter(by amount: Int = 1) {
        profile.score += amount
        saveProfile()
    }

    func addCoins(_ amount: Int) {
        incrementCounter(by: amount)
    }

    // MARK: - Navigation helpers
    func openInfo() { path.append(.info) }
    func openMenu() { path.append(.menu) }
    func openGame(level: Int? = nil) {
        if let level { currentLevel = level }
        path.append(.game)
    }
    func openLevels() { path.append(.levels) }
    func openShop() { path.append(.shop) }
    func openProfile() { path.append(.profile) }
    func openSettings() { path.append(.settings) }
    func openLeaderboard() { path.append(.leaderboard) }
    func openPrivacy() { path.append(.privacy) }
    func openTerms() { path.append(.terms) }
    func openEndGame() { path.append(.endGame) }

    func pop() { _ = path.popLast() }
    func popToRoot() { path.removeAll() }
}

