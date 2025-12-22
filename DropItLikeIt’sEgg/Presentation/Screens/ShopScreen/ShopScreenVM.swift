//
//  ShopScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import Foundation
import Combine


@MainActor
final class ShopScreenVM: ObservableObject {
    @Published var showNoCoinsAlert: Bool = false
    @Published var activeAlert: ShopAlert? = nil
    
    @Published var hasUnlockedLevels: Bool = false
    @Published var hasNoAds: Bool = false
    
    private let appVM: ContentVM
    
    private let unlockedLevelsSaver = DefaultsDataSaver<Bool>(key: "shop_unlocked_levels")
    private let noAdsSaver = DefaultsDataSaver<Bool>(key: "shop_no_ads")
    
    init(appVM: ContentVM) {
        self.appVM = appVM
        hasUnlockedLevels = unlockedLevelsSaver.getValue() ?? false
        hasNoAds = noAdsSaver.getValue() ?? false
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
        unlockedLevelsSaver.save(true)
        activeAlert = .levelsUnlocked
        appVM.openGame(level: appVM.currentLevel + 1)
    }
    
    func purchaseNoAds() {
        // TODO: Implement actual purchase logic
        print("Purchase No Ads for $3")
        hasNoAds = true
        noAdsSaver.save(true)
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
