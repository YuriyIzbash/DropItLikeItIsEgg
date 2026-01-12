//
//  LeaderBoardScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import Combine
import UIKit

@MainActor
final class LeaderBoardScreenVM: BaseModel {
    @Published private(set) var leaderboardMockData: [LeaderboardMockData] = []
    
    var profile: UserProfile {
        userProfileService.profile
    }
    private var cancellables = Set<AnyCancellable>()
    
    override init(_ services: Services) {
        super.init(services)
        
        userProfileService.$profile
            .sink { [weak self] _ in
                self?.loadMockLeaderboard()
            }
            .store(in: &cancellables)
        
        loadMockLeaderboard()
    }
    
    private func loadMockLeaderboard() {
        let entries = leaderboardService.getMockLeaderboard(currentUser: userProfileService.profile)
        leaderboardMockData = entries.map { entry in
            let image = entry.image ?? UIImage(imageLiteralResourceName: "profilePlaceholder")
            return LeaderboardMockData(username: entry.username, score: entry.score, image: image)
        }
        .sorted { $0.score > $1.score }
    }
}

