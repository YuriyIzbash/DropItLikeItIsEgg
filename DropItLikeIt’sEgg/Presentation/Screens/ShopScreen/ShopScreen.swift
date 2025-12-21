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
    @EnvironmentObject private var appVM: ContentVM
    @State private var showNoCoinsAlert = false
    
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
            if appVM.profile.score <= 0 {
                showNoCoinsAlert = true
            }
        }
        .customAlert(
            title: "Warning",
            message: "You need coins to play",
            isPresented: $showNoCoinsAlert
        )
    }
}

private extension ShopScreen {
    var header: some View {
        HStack {
            NavBtn(type: .back) { if appVM.profile.score <= 0 { appVM.popToRoot() } else { dismiss() } }
            
            
            Spacer()
            
            CoinCounterView(amount: appVM.profile.score, isInteractive: false)
                .id(appVM.profile.score)
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
            UserInfoRow(offerName: "1000 coins", price: 1, onTap: { appVM.addCoins(1000) })
            
            UserInfoRow(offerName: "Unlock levels", price: 1, onTap: { appVM.unlockLevels(upTo: 9) })
            
            UserInfoRow(offerName: "No Ads", price: 3, onTap: {})
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

#Preview {
    ShopScreen()
        .environmentObject(ContentVM())
}
