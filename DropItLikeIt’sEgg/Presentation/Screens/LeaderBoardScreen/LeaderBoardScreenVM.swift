//
//  LeaderBoardScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import Foundation
import Combine
import UIKit

@MainActor
final class LeaderBoardScreenVM: BaseModel {
    @Published var profile = UserProfile()
    @Published var leaderboardMockData: [LeaderboardMockData] = []
    
    override init(_ services: Services) {
        super.init(services)
        load()
    }
    
    func load() {
        if let loaded: UserProfile = userProfileService.load() {
            profile = loaded
        }
        loadMockLeaderboard()
    }
    
    private func loadMockLeaderboard() {
        let entries = leaderboardService.getMockLeaderboard(currentUser: profile)
        leaderboardMockData = entries.map { entry in
            let image = UIImage(named: entry.imageName) ?? UIImage(imageLiteralResourceName: "profilePlaceholder")
            return LeaderboardMockData(username: entry.username, score: entry.score, image: image)
        }
        .sorted { $0.score > $1.score }
    }
}

