//
//  MenuScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct MenuScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: MenuScreenVM
    
    var body: some View {
        ZStackWithBackground {
            VStack {
                VStack(spacing: 16) {
                    Text("MENU")
                        .customFont(size: 32, scaleFactor: 1.0)
                    
                    Group {
                        MainBtn(title: "PROFILE", size: .small, action: vm.openProfile)
                        
                        MainBtn(title: "SETTINGS", size: .small, action: vm.openSettings)
                        
                        MainBtn(title: "LEADER BOARD", size: .small, action: vm.openLeaderboard)
                        
                        MainBtn(title: "PRIVACY POLICY", size: .small, action: vm.openPrivacy)
                        
                        MainBtn(title: "TERMS OF USE", size: .small, action: vm.openTerms)
                    }
                }
                .frame(maxWidth: .infinity)
                .padding(.vertical, 16)
                .background(
                    RoundedRectangle(cornerRadius: 8)
                        .fill(Color.appMain)
                        .overlay(
                            RoundedRectangle(cornerRadius: 8)
                                .stroke(Color.appPink, lineWidth: 2)
                        )
                )
            }
            .padding(.horizontal, 32)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                NavBtn(type: .back) { dismiss() }
                
                Spacer()
                
                CoinCounterView(amount: vm.coinAmount, onTap: vm.openShop)
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
        .onAppear {
            vm.load()
        }
    }
}

#Preview {
    MenuScreen(vm: .init(appVM: ContentVM(Services.shared), services: Services.shared))
}

