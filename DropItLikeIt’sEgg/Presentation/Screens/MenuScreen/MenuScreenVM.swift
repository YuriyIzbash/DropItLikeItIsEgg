//
//  MenuScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import Combine

@MainActor
final class MenuScreenVM: BaseModel {
    @Published var coinAmount: Int = 0
    
    private let appVM: ContentVM
    
    init(appVM: ContentVM, services: Services) {
        self.appVM = appVM
        super.init(services)
        load() 
    }
    
    func openShop() {
        appVM.openShop()
    }
    
    func openProfile() {
        appVM.openProfile()
    }
    
    func openSettings() {
        appVM.openSettings()
    }
    
    func openLeaderboard() {
        appVM.openLeaderboard()
    }
    
    func openPrivacy() {
        appVM.openPrivacy()
    }
    
    func openTerms() {
        appVM.openTerms()
    }
    
    func load() {
        coinAmount = userProfileService.load()?.score ?? 0
    }
}
