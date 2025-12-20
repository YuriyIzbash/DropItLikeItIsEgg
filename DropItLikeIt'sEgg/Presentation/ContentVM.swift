//
//  ContentVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import Combine

@MainActor
final class ContentVM: ObservableObject {
    @Published var path: [AppRoute] = []
    
    func openInfo() { path.append(.info) }
    func openMenu() { path.append(.menu) }
    func openGame(level: Int = 1) { path.append(.game(level: level)) }
    func openLevels() { path.append(.levels) }
    func openProfile() { path.append(.profile) }
    func openSettings() { path.append(.settings) }
    func openLeaderboard() { path.append(.leaderboard) }
    func openPrivacy() { path.append(.privacy) }
    func openTerms() { path.append(.terms) }
    
    func pop() { _ = path.popLast() }
    func popToRoot() { path.removeAll() }
}
