//
//  ContentView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var coordinator = Coordinator.shared
    @StateObject private var appVM: ContentVM
    
    private let services: Services
    
    init(services: Services) {
        self.services = services
        _appVM = StateObject(wrappedValue: ContentVM(services))
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            HomeScreen(services: services)
                .navigationDestination(for: AppRoute.self) { route in
                    switch route {
                    case .info:
                        InfoView()
                    case .menu:
                        MenuScreen(vm: .init(appVM: appVM, services: services))
                    case .levels:
                        LevelsScreen(vm: .init(appVM: appVM, services: services))
                    case .game:
                        GameScreen(vm: .init(services), appVM: appVM)
                    case .profile:
                        ProfileScreen(vm: .init(services))
                    case .settings:
                        SettingsScreen(vm: .init(services))
                    case .leaderboard:
                        LeaderBoardScreen(vm: .init(services))
                    case .privacy:
                        PrivacyView()
                    case .terms:
                        TermsView()
                    case .shop:
                        ShopScreen(vm: .init(appVM: appVM, services: services))
                    case .endGame:
                        EndGameView(appVM: appVM)
                    }
                }
        }
    }
}

#Preview {
    ContentView(services: Services.shared)
}
