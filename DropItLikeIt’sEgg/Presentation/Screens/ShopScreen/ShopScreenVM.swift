//
//  ShopScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import Foundation
import Combine

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
    
    func alertOnAppear() {
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
        print("Purchase 1000 coins for $1")
        appVM.addCoins(1000)
        activeAlert = .coinsPurchased
    }
    
    func purchaseUnlockLevels() {
        // TODO: Implement actual purchase logic
        print("Unlock levels for $1")
        appVM.unlockLevels(upTo: 9)
        hasUnlockedLevels = true
        shopService.setUnlockedLevels(true)
        activeAlert = .levelsUnlocked
        appVM.openGame(level: appVM.currentLevel + 1)
    }
    
    func purchaseNoAds() {
        // TODO: Implement actual purchase logic
        print("Purchase No Ads for $3")
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
    }

    var activeAlertTitle: String {
        switch activeAlert {
        case .noCoins:
            return "Warning"
        case .coinsPurchased:
            return "Congrats!"
        case .levelsUnlocked:
            return "Congrats!"
        case .noAds:
            return "Congrats!"
        case .none:
            return ""
        }
    }

    var activeAlertMessage: String {
        switch activeAlert {
        case .noCoins:
            return "You need coins to play"
        case .coinsPurchased:
            return "You have purchased 1000 coins!"
        case .levelsUnlocked:
            return "You have unlocked all levels!"
        case .noAds:
            return "No ads anymore!"
        case .none:
            return ""
        }
    }
}
