//
//  MenuScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct MenuScreen: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appVM: ContentVM
    
    var body: some View {
        GeometryReader { proxy in
            ZStackWithBackground {
                
            }
            .overlay(alignment: .center) {
                VStack {
                    HStack {
                        NavBtn(type: .back) { dismiss() }
                        
                        Spacer()
                        
                        ZStack(alignment: .trailing) {
                            ZStack(alignment: .leading) {
                                Image(.coinCounter)
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 100)
                                
                                Text("1000")
                                    .customFont(size: 12)
                                    .padding(.leading, 8)
                            }
                        }
                        .offset(x: -30)
                    }
                    .padding(.bottom, 56)
                    .padding(.horizontal, 24)
                    
                    VStack {
                        Text("MENU")
                            .customFont(size: 32)
                            .padding(.vertical, 16)
                        
                        Group {
                            MainBtn(title: "PROFILE", action: { appVM.openProfile() })
                            
                            MainBtn(title: "SETTINGS", action: { appVM.openSettings() })
                            
                            MainBtn(title: "LEADER BOARD", action: { appVM.openLeaderboard() })
                            
                            MainBtn(title: "PRIVACY POLICY", action: { appVM.openPrivacy() })
                            
                            MainBtn(title: "TERMS OF USE", action: { appVM.openTerms() })
                        }
                        .frame(height: proxy.size.height * 0.1)
                        .padding(.horizontal, proxy.size.width * 0.25)
                        .padding(.bottom, 32)
                    }
                    .background(
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.appMain)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.appPink, lineWidth: 2)
                            )
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .offset(x: -15)
                    .padding(.horizontal, 40)
                }
            }
        }
    }
}

#Preview {
    MenuScreen()
}

