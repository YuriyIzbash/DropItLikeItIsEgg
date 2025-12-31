//
//  MenuScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import Combine

final class MenuScreenVM: BaseModel {
    @Published private(set) var coinAmount: Int = 0
    
    private let appVM: ContentVM
    
    init(appVM: ContentVM, services: Services) {
        self.appVM = appVM
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
