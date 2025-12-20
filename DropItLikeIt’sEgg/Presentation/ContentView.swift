//
//  ContentView.swift
//  DropItLikeIt’sEgg
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
                        MenuScreen()
                    case .levels:
                        LevelsScreen()
                    case .game:
                        GameScreen(vm: GameScreenVM())
                    case .profile:
                        ProfileScreen(vm: ProfileScreenVM())
                    case .settings:
                        SettingsScreen()
                    case .leaderboard:
                        LeaderBoardScreen()
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
