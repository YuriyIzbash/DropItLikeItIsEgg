//
//  LeaderBoardScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import Foundation
import Combine

@MainActor
final class LeaderBoardScreenVM: ObservableObject {
    @Published var profile = UserProfile()
    @Published var leaderboardMockData: [LeaderboardMockData] = []
    
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    
    init() {
        load()
    }
    
    func load() {
        if let loaded: UserProfile = profileSaver.getValue() {
            profile = loaded
        }
        loadMockLeaderboard()
    }
    
    private func loadMockLeaderboard() {
        leaderboardMockData = [
            LeaderboardMockData(username: "EggMaster3000", score: 1000),
            LeaderboardMockData(username: "DropQueen", score: 1200),
            LeaderboardMockData(username: "YolkSlayer", score: 11200),
            LeaderboardMockData(username: "ShellShock", score: 9800),
            LeaderboardMockData(username: "EggCellent", score: 8500),
            LeaderboardMockData(username: "Scrambler", score: 7300),
            LeaderboardMockData(username: "OmeletteKing", score: 6500),
            LeaderboardMockData(username: "HatchMaster", score: 5800),
        ].sorted { $0.score > $1.score }
    }
}

