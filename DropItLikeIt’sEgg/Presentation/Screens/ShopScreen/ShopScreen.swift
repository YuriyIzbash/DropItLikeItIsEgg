//
//  ShopScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import SwiftUI
import UIKit

struct ShopScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: ShopScreenVM
    
    private var content: some View {
        VStack(alignment: .leading) {
            header
            shopCard
        }
        .padding(.horizontal, 32)
        .frame(maxHeight: .infinity, alignment: .top)
    }
    
    var body: some View {
        ZStackWithBackground {
            content
        }
        .onAppear {
            vm.onAppear()
        }
        .customAlert(
            title: vm.activeAlertTitle,
            message: vm.activeAlertMessage,
            isPresented: Binding(
                get: { vm.activeAlert != nil },
                set: { newValue in if !newValue { vm.activeAlert = nil } }
            )
        )
    }
}

private extension ShopScreen {
    var header: some View {
        HStack {
            NavBtn(type: .back) {
                vm.handleBackAction { dismiss() }
            }
            
            Spacer()
            
            CoinCounterView(amount: vm.score, isInteractive: false)
                .id(vm.score)
        }
        .padding(.bottom, 32)
    }
    
    var shopCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.appMain)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.appPink, lineWidth: 2)
            )
            .overlay(shopContent, alignment: .top)
        
    }
    
    var shopContent: some View {
        VStack(spacing: 0) {
            Text("SHOP")
                .customFont(size: 24)
                .padding(.top, 56)
                .padding(.bottom, 16)
            
            UserInfoRow(offerName: "1000 coins", price: 1, onTap: {
                vm.purchaseCoins()
            })
            
            if !vm.hasUnlockedLevels {
                UserInfoRow(offerName: "Unlock levels", price: 1, onTap: {
                    vm.purchaseUnlockLevels()
                })
            }
            
            if !vm.hasNoAds {
                UserInfoRow(offerName: "No Ads", price: 3, onTap: {
                    vm.purchaseNoAds()
                })
            }
        }
        .padding(.horizontal, 24)
    }
}

private struct UserInfoRow: View {
    let offerName: String
    let price: Int
    var onTap: (() -> Void)? = nil
    
    var body: some View {
        ZStack {
            HStack(spacing: 12) {
                Text(offerName)
                    .customFont(size: 16)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                NavBtn(type: .empty, action: {
                    print("Follow to paywall")
                    onTap?()
                })
                    .overlay(
                        Text("\(price)$")
                            .customFont(size: 16)
                    )
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 120)
    }
}

extension ShopScreenVM {
    enum ShopAlert: Equatable {
        case noCoins
        case coinsPurchased
        case levelsUnlocked
        case noAds
    }

    var activeAlertTitle: String {
        switch activeAlert {
        case .noCoins:
            return "Warning"
        case .coinsPurchased:
            return "Congrats!"
        case .levelsUnlocked:
            return "Congrats!"
        case .noAds:
            return "Congrats!"
        case .none:
            return ""
        }
    }

    var activeAlertMessage: String {
        switch activeAlert {
        case .noCoins:
            return "You need coins to play"
        case .coinsPurchased:
            return "You have purchased 1000 coins!"
        case .levelsUnlocked:
            return "You have unlocked all levels!"
        case .noAds:
            return "No ads anymore!"
        case .none:
            return ""
        }
    }
}

#Preview {
    ShopScreen(vm: ShopScreenVM(appVM: ContentVM()))
}
