//
//  ContentView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct ContentView: View {
    @ObservedObject private var coordinator = Coordinator.shared
    @StateObject private var vm: ContentVM
    
    private let services: Services
    
    init(services: Services) {
        self.services = services
        _vm = StateObject(wrappedValue: ContentVM(services))
    }
    
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStackWithBackground {
                Image(.chicken1)
                    .resizable()
                    .scaledToFit()
                    .frame(maxWidth: .infinity)
                    .padding(.horizontal, 48)
                    .padding(.top, 32)
                
                MainBtn(title: "PLAY", action: vm.openLevels)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .frame(maxHeight: .infinity, alignment: .bottom)
                    .padding(.horizontal, 56)
                    .padding(.bottom, 32)
            }
            .topBar(
                leading: {
                    NavBtn(type: .info, action: vm.openInfo)
                },
                trailing: {
                    NavBtn(type: .menu, action: vm.openMenu)
                }
            )
            .overlay {
                if vm.isProgressVisible {
                    CustomProgressView(onFinished: {
                        withAnimation(.easeInOut(duration: 0.35)) {
                            vm.hideProgress()
                        }
                    })
                    .transition(.opacity)
                }
            }
            .animation(.easeInOut(duration: 0.35), value: vm.isProgressVisible)
            .navigationDestination(for: AppRoute.self, destination: navigationDestination)
        }
    }
    
    @ViewBuilder
    private func navigationDestination(for route: AppRoute) -> some View {
        switch route {
        case .info:
            InfoView()
        case .menu:
            MenuScreen(vm: .init(services))
        case .levels:
            LevelsScreen(vm: .init(services))
        case .game(let level):
             GameScreen(vm: .init(services), level: level)
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
            ShopScreen(vm: .init(services))
        case .endGame:
            EndGameView()
        }
    }
}

#Preview {
    ContentView(services: Services.shared)
}
