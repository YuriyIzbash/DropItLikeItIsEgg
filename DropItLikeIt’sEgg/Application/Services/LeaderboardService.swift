//
//  LeaderboardService.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import UIKit

@MainActor
final class LeaderboardService {
    static let shared = LeaderboardService()
    private init() {}
    
    // TODO: - Fetch from network or persistence
    func getMockLeaderboard(currentUser: UserProfile) -> [LeaderboardMockData] {
        var entries: [LeaderboardMockData] = [
            LeaderboardMockData(
                username: "TOM",
                score: 2500,
                image: UIImage(imageLiteralResourceName: "profilePlaceholder")
            ),
            LeaderboardMockData(
                username: "JERRY",
                score: 2200,
                image: UIImage(imageLiteralResourceName: "profilePlaceholder")
            ),
            LeaderboardMockData(
                username: "SPIKE",
                score: 1800,
                image: UIImage(imageLiteralResourceName: "profilePlaceholder")
            ),
            LeaderboardMockData(
                username: "TYKE",
                score: 1500,
                image: UIImage(imageLiteralResourceName: "coin1")
            )
        ]
        
        let me = LeaderboardMockData(
            username: currentUser.username.isEmpty ? "YOU" : currentUser.username,
            score: currentUser.score,
            image: currentUser.image ?? UIImage(imageLiteralResourceName: "profilePlaceholder")
        )
        
        entries.insert(me, at: 0)
        
        return entries
    }
}
