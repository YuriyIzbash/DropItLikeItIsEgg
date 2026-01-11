//
//  LeaderboardMockData.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import UIKit

struct LeaderboardMockData: Identifiable, Equatable {
    var id: UUID = UUID()
    var username: String
    var score: Int
    var image: UIImage?
}
