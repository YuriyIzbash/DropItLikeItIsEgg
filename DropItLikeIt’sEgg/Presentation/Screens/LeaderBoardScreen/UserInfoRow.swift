//
//  UserInfoRow.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI

struct UserInfoRow: View {
    let username: String
    let score: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.appPink)
            
            HStack(spacing: 8) {
                Text(username.isEmpty ? "USERNAME" : username)
                    .customFont(size: 14)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(score)")
                    .customFont(size: 12)
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 48)
    }
}
