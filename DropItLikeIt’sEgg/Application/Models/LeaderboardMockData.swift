//
//  LeaderboardMockData.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation
import UIKit

struct LeaderboardMockData: Identifiable {
    let id = UUID()
    let username: String
    let score: Int
    let image: UIImage
}
