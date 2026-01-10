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
    
    var body: some View {
        ZStackWithBackground {
            shopCard
                .padding(.horizontal, 32)
        }
        .topBar(
            leading: {
                NavBtn(type: .back) {
                    vm.handleBackAction(dismiss: dismiss.callAsFunction)
                }
            },
            trailing: {
                CoinCounterView(amount: vm.score, isInteractive: false)
                    .id(vm.score)
            }
        )
        .onAppear {
            vm.showAlertOnAppear()
        }
        .customAlert(
            state: $vm.activeAlert,
            title: vm.activeAlert?.title ?? "",
            message: vm.activeAlert?.message ?? ""
        )
    }
}

private extension ShopScreen {
    var shopCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.appMain)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.appPink, lineWidth: 2)
            )
            .overlay(shopContent, alignment: .top)
            .padding(.vertical, 48)
    }
    
    var shopContent: some View {
        VStack(spacing: 0) {
            Text("SHOP")
                .customFont(size: 24)
                .padding(.top, 56)
                .padding(.bottom, 16)
            
            ShopRow(offerName: "1000 coins", price: 1, action: vm.purchaseCoins)
            
            if !vm.hasUnlockedLevels {
                ShopRow(offerName: "Unlock levels", price: 1, action: vm.purchaseUnlockLevels)
            }
            
            if !vm.hasNoAds {
                ShopRow(offerName: "No Ads", price: 3, action: vm.purchaseNoAds)
            }
        }
        .padding(.horizontal, 12)
    }
}

#Preview {
    ShopScreen(vm: ShopScreenVM(appVM: ContentVM(Services.shared), services: Services.shared))
}

