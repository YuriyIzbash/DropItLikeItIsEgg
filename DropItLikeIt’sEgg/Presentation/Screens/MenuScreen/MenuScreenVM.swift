//
//  MenuScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import Combine

@MainActor
final class MenuScreenVM: BaseModel {
    var coinAmount: Int {
        userProfileService.profile.score
    }
    
    private var cancellables = Set<AnyCancellable>()
    
    override init(_ services: Services) {
        super.init(services)
        
        userProfileService.$profile
            .map { $0.score }
            .removeDuplicates()
            .sink { [weak self] _ in
                self?.objectWillChange.send()
            }
            .store(in: &cancellables)
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
}
