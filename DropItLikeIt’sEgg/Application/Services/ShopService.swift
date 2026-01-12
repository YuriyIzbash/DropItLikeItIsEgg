//
//  ShopService.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation
import Combine

@MainActor
final class ShopService: ObservableObject {
    @PublishedStored(wrappedValue: false, key: "shop.isLevelsUnlocked") var hasUnlockedLevels: Bool
    @PublishedStored(wrappedValue: false, key: "shop.isAdsDisabled") var hasNoAds: Bool
    
    private var cancellables = Set<AnyCancellable>()
    
    init() {
        $hasUnlockedLevels
            .sink { [weak self] _ in self?.objectWillChange.send() }
            .store(in: &cancellables)
        
        $hasNoAds
            .sink { [weak self] _ in self?.objectWillChange.send() }
            .store(in: &cancellables)
    }
    
    func setUnlockedLevels(_ value: Bool) { hasUnlockedLevels = value }
    
    func setNoAds(_ value: Bool) { hasNoAds = value }
}
