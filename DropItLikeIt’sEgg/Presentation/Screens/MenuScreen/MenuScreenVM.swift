//
//  MenuScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import Combine

@MainActor
final class MenuScreenVM: BaseModel {
    @Published private(set) var coinAmount: Int = 0
    
    override init(_ services: Services) {
        super.init(services)
        
        load()
    }
    
    func openShop() {
        push(.shop)
    }
    
    func openProfile() {
        push(.profile)
    }
    
    func openSettings() {
        push(.settings)
    }
    
    func openLeaderboard() {
        push(.leaderboard)
    }
    
    func openPrivacy() {
        push(.privacy)
    }
    
    func openTerms() {
        push(.terms)
    }
    
    func load() {
        coinAmount = userProfileService.load()?.score ?? 0
    }
}
