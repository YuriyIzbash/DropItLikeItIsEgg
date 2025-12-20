//
//  LeaderBoardScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI
import UIKit

struct LeaderBoardScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: LeaderBoardScreenVM
    
    private var content: some View {
        VStack(alignment: .leading) {
            header
            leaderBoardCard
        }
        .padding(.horizontal, 32)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            vm.load()
        }
    }
    
    var body: some View {
        ZStackWithBackground {
            content
        }
    }
}

private extension LeaderBoardScreen {
    var header: some View {
        NavBtn(type: .back) { dismiss() }
            .padding(.bottom, 32)
    }
    
    var leaderBoardCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.appMain)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.appPink, lineWidth: 2)
            )
            .overlay(leaderBoardContent, alignment: .top)
        
    }
    
    var leaderBoardContent: some View {
        VStack(spacing: 0) {
            Text("LEADER BOARD")
                .customFont(size: 24)
                .padding(.top, 56)
                .padding(.bottom, 16)
            
            ScrollView {
                UserInfoRow(username: vm.profile.username, score: vm.profile.score)
                    .padding(.leading, 48)
                
                avatarView
                    .frame(maxWidth: .infinity, alignment: .leading)
            }
        }
        .padding(.horizontal, 24)
    }
    
    var avatarView: some View {
        Group {
            if let image = vm.profile.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 60, height: 60)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.appPink, lineWidth: 2)
                    )
                    .contentShape(RoundedRectangle(cornerRadius: 8))
            } else {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.appPink)
                    .frame(width: 60, height: 60)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appPink, lineWidth: 2)
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
                .fill(Color.appPink)
            
            HStack(spacing: 12) {
                Text(username.isEmpty ? "USERNAME" : username)
                    .customFont(size: 16)
                    .lineLimit(1)
                    .frame(maxWidth: .infinity, alignment: .leading)
                
                Text("\(score)")
                    .customFont(size: 16)
            }
            .padding(.horizontal, 16)
        }
        .frame(height: 48)
    }
}

#Preview {
    LeaderBoardScreen(vm: LeaderBoardScreenVM())
}
