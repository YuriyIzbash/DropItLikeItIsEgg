//
//  ShopScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import Foundation
import Combine
import os

@MainActor
final class ShopScreenVM: BaseModel {
    @Published private(set) var showNoCoinsAlert: Bool = false
    @Published var activeAlert: ShopAlert? = nil
    @Published private(set) var hasUnlockedLevels: Bool = false
    @Published private(set) var hasNoAds: Bool = false
    
    var score: Int {
        userProfileService.profile.score
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(_ services: Services) {
        super.init(services)
        
        hasUnlockedLevels = shopService.hasUnlockedLevels()
        hasNoAds = shopService.hasNoAds()
        
        userProfileService.$profile
            .map { $0.score }
            .removeDuplicates()
            .sink { [weak self] newScore in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
    }
    
    var hasNoCoins: Bool {
        score <= 0
    }
    
    func showAlertOnAppear() {
        if hasNoCoins {
            activeAlert = .noCoins
        }
    }
    
    func handleBackAction(dismiss: () -> Void) {
        if hasNoCoins {
            popToRoot()
        } else {
            dismiss()
        }
    }
    
    // MARK: - Shop Actions
    func purchaseCoins() {
        logger.log("Purchase 1000 coins for $1")
        let added = 1000
        
        var updatedProfile = userProfileService.profile
        updatedProfile.score += added
        userProfileService.profile = updatedProfile
        
        activeAlert = .coinsPurchased
    }
    
    func purchaseUnlockLevels() {
        logger.log("Unlock levels for $1")
        levelsService.saveMaxUnlockedLevel(9)
        hasUnlockedLevels = true
        shopService.setUnlockedLevels(true)
        activeAlert = .levelsUnlocked
        push(.game(level: 7))
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
