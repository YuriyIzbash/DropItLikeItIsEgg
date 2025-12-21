//
//  MenuScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import Combine

@MainActor
final class MenuScreenVM: ObservableObject {
    @Published var coinAmount: Int = 1000
    
    private let appVM: ContentVM
    
    init(appVM: ContentVM) {
        self.appVM = appVM
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
}
