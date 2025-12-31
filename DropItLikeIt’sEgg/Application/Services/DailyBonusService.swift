//
//  DailyBonusService.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation

@MainActor
final class DailyBonusService: DefaultsDataSaver<Date> {
    init() {
        super.init(key: "user.lastDailyBonus")
    }
    
    func getLastBonusDate() -> Date? {
        super.getValue()
    }
    
    func saveLastBonusDate(_ date: Date) {
        super.save(date)
    }
}
