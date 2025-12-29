//
//  Coordinator.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import SwiftUI
import Combine

enum AppRoute: Hashable {
    case info
    case menu
    case levels
    case game
    case shop
    case profile
    case settings
    case leaderboard
    case privacy
    case terms
    case endGame
}

final class Coordinator: ObservableObject {
    @Published var path: [AppRoute] = []

    static let shared = Coordinator()

    private init() {}

    func push(_ route: AppRoute) {
        path.append(route)
    }

    func popToRoot() {
        path.removeAll()
    }
}
