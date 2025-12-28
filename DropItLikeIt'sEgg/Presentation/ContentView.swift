//
//  ContentView.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct ContentView: View {
    @StateObject private var appVM = ContentVM()
    
    var body: some View {
        NavigationStack(path: $appVM.path) {
            ProgressView()
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .info:
                        InfoView()
                    case .menu:
                        MenuScreen(vm: .init(appVM: appVM))
                    case .levels:
                        LevelsScreen(vm: .init(appVM: appVM))
                    case .game(let level):
                        GameScreen(level: level)
                    case .profile:
                        ProfileScreen(vm: .init())
                    case .settings:
                        SettingsScreen(vm: .init())
                    case .leaderboard:
                        LeaderBoardScreen(vm: .init())
                    case .privacy:
                        PrivacyView()
                    case .terms:
                        TermsView()
                    }
                }
        }
        .environmentObject(appVM)
    }
}

#Preview {
    ContentView()
}
