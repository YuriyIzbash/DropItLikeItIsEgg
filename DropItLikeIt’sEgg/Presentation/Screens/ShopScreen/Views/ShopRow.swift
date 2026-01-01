//
//  ShopRow.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI
import os

struct ShopRow: View, Loggerable {
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
                    logger.log("Follow to paywall")
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
