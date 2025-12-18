//
//  LeaderBoardView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI
import UIKit

struct LeaderBoardView: View {
    @State private var profile = UserProfile()
    
    var body: some View {
        ZStack {
            MainBackground()
            
            content
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            header
            profileCard
        }
        .padding(.horizontal, 32)
        .frame(maxHeight: .infinity, alignment: .top)
    }
}

private extension LeaderBoardView {
    var header: some View {
        SquareBtn(type: .back) {
            print("Back tapped")
        }
        .padding(.bottom, 32)
    }
    
    var profileCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.mainOpaque)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.strokeMain, lineWidth: 2)
            )
            .overlay(profileContent, alignment: .top)
        
    }
    
    var profileContent: some View {
        VStack(spacing: 0) {
            Text("LEADER BOARD")
                .font(.subtitle)
                .appTextStyle()
                .padding(.top, 56)
                .padding(.bottom, 16)
            
            ScrollView {
                UserInfoRow(username: profile.username, score: profile.score)
                    .padding(.leading, 48)
                
                avatarView
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 24)
    }
    
    var avatarView: some View {
        Group {
            if let image = profile.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.strokeMain, lineWidth: 2)
                    )
                    .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
            } else {
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .fill(Color.textFields)
                    .frame(width: 60, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.strokeMain, lineWidth: 2)
                    )
            }
        }
    }
}

private struct UserInfoRow: View {
    let username: String
    let score: Int
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.textFields)
            
            HStack(spacing: 12) {
                Text(username.isEmpty ? "USERNAME" : username)
                    .font(.placeholderText)
                    .lineLimit(1)
                    .foregroundStyle(Color.white)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(score)")
                    .font(.placeholderText)
                    .foregroundStyle(Color.white)
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 48)
    }
}

private struct MainBackground: View {
    var body: some View {
        Image("backgroundMain")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    LeaderBoardView()
}
