//
//  ShopScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import Foundation
import Combine
import os

final class ShopScreenVM: BaseModel {
    @Published private(set) var showNoCoinsAlert: Bool = false
    @Published var activeAlert: ShopAlert? = nil
    @Published private(set) var hasUnlockedLevels: Bool = false
    @Published private(set) var hasNoAds: Bool = false
    
    private let appVM: ContentVM
    
    init(appVM: ContentVM, services: Services) {
        self.appVM = appVM
        super.init(services)
        hasUnlockedLevels = shopService.hasUnlockedLevels()
        hasNoAds = shopService.hasNoAds()
    }
    
    var score: Int {
        appVM.profile.score
    }
    
    var hasNoCoins: Bool {
        appVM.profile.score <= 0
    }
    
    func showAlertOnAppear() {
        if hasNoCoins {
            activeAlert = .noCoins
        }
    }
    
    func handleBackAction(dismiss: () -> Void) {
        if hasNoCoins {
            appVM.popToRoot()
        } else {
            dismiss()
        }
    }
    
    // MARK: - Shop Actions
    func purchaseCoins() {
        // TODO: Implement actual purchase logic
        logger.log("Purchase 1000 coins for $1")
        appVM.addCoins(1000)
        activeAlert = .coinsPurchased
    }
    
    func purchaseUnlockLevels() {
        // TODO: Implement actual purchase logic
        logger.log("Unlock levels for $1")
        appVM.unlockLevels(upTo: 9)
        hasUnlockedLevels = true
        shopService.setUnlockedLevels(true)
        activeAlert = .levelsUnlocked
        appVM.openGame(level: appVM.currentLevel + 1)
    }
    
    func purchaseNoAds() {
        // TODO: Implement actual purchase logic
        logger.log("Purchase No Ads for $3")
        hasNoAds = true
        shopService.setNoAds(true)
        activeAlert = .noAds
    }
}

extension ShopScreenVM {
    enum ShopAlert: Equatable {
        case noCoins
        case coinsPurchased
        case levelsUnlocked
        case noAds
        
        var title: String {
            switch self {
            case .noCoins: "Warning"
            case .coinsPurchased: "Congrats!"
            case .levelsUnlocked: "Congrats!"
            case .noAds: "Congrats!"
            }
        }
        
        var message: String {
            switch self {
            case .noCoins: "You need coins to play"
            case .coinsPurchased: "You have purchased 1000 coins!"
            case .levelsUnlocked: "You have unlocked all levels!"
            case .noAds: "No ads anymore!"
            }
        }
    }
}
