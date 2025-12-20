//
//  NavigationRouter.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import Foundation

enum AppRoute: Hashable {
    case info
    case menu
    case levels
    case game(level: Int)
    case profile
    case settings
    case leaderboard
    case privacy
    case terms
}

