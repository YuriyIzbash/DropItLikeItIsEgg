//
//  MenuScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import Combine

@MainActor
final class MenuScreenVM: ObservableObject {
    @Published var coinAmount: Int = 0
    
    private let appVM: ContentVM
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    
    init(appVM: ContentVM) {
        self.appVM = appVM
        
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
        coinAmount = profileSaver.getValue()?.score ?? 0
    }
}
