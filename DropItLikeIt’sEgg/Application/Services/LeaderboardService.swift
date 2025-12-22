import Foundation
import UIKit

struct LeaderboardEntry: Identifiable, Equatable, Codable {
    let id: UUID
    var username: String
    var score: Int
    var imageName: String
    
    init(id: UUID = UUID(), username: String, score: Int, imageName: String) {
        self.id = id
        self.username = username
        self.score = score
        self.imageName = imageName
    }
}

@MainActor
final class LeaderboardService {
    static let shared = LeaderboardService()
    private init() {}
    
    // TODO: - Fetch from network or persistence
    func getMockLeaderboard(currentUser: UserProfile) -> [LeaderboardEntry] {
        var entries: [LeaderboardEntry] = [
            LeaderboardEntry(username: "TOM", score: 2500, imageName: "avatar1"),
            LeaderboardEntry(username: "JERRY", score: 2200, imageName: "avatar2"),
            LeaderboardEntry(username: "SPIKE", score: 1800, imageName: "avatar3"),
            LeaderboardEntry(username: "TYKE", score: 1500, imageName: "avatar4")
        ]
        
        let me = LeaderboardEntry(username: currentUser.username.isEmpty ? "YOU" : currentUser.username,
                                  score: currentUser.score,
                                  imageName: "profilePlaceholder")
        entries.insert(me, at: 0)
        return entries
    }
}
