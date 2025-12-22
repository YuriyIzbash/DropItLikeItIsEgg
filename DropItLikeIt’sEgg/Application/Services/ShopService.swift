//
//  ShopService.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation

final class ShopService {
    private let unlockedLevelsSaver = DefaultsDataSaver<Bool>(key: "shop_unlocked_levels")
    private let noAdsSaver = DefaultsDataSaver<Bool>(key: "shop_no_ads")
    
    func hasUnlockedLevels() -> Bool {
        unlockedLevelsSaver.getValue() ?? false
    }
    
    func setUnlockedLevels(_ value: Bool) {
        unlockedLevelsSaver.save(value)
    }
    
    func hasNoAds() -> Bool {
        noAdsSaver.getValue() ?? false
    }
    
    func setNoAds(_ value: Bool) {
        noAdsSaver.save(value)
    }
}
