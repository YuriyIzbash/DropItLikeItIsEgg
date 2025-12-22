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
            leaderBoardCard
        }
        .padding(.horizontal, 32)
    }
    
    var body: some View {
        ZStackWithBackground {
            content
                .padding(.top, 32)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                NavBtn(type: .back) { dismiss() }
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
    }
}

private extension LeaderBoardScreen {
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
                .padding(.vertical, 16)
            
            ScrollView(showsIndicators: false) {
                VStack(spacing: 12) {
                    HStack(spacing: 12) {
                        avatarView
                        
                        UserInfoRow(username: vm.profile.username, score: vm.profile.score)
                    }
                    
                    Divider()
                        .background(Color.gray)
                    
                    ForEach(Array(vm.leaderboardMockData.enumerated()), id: \.element.id) { index, entry in
                        HStack(spacing: 12) {
                            mockAvatarView(image: entry.image)
                            
                            UserInfoRow(username: entry.username, score: entry.score)
                        }
                    }
                }
            }
            .padding(.bottom, 32)
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
    
    func mockAvatarView(image: UIImage) -> some View {
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
    }
}

#Preview {
    LeaderBoardScreen(vm: LeaderBoardScreenVM())
}
