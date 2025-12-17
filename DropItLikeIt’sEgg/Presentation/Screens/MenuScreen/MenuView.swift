//
//  MenuView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct MenuView: View {
    var body: some View {
        Color.clear
            .edgesIgnoringSafeArea(.all)
            .background(
                ZStack {
                    Image("backgroundMain")
                        .resizable()
                        .scaledToFill()
                    
                }
                    .ignoresSafeArea()
            )
            .overlay(
                ZStack {
                    VStack(alignment: .leading) {
                        HStack {
                            SquareBtn(type: .back) {
                                print("Back tapped")
                            }
                            
                            Spacer()
                            
                            ZStack(alignment: .trailing) {
                                ZStack(alignment: .leading) {
                                    Image(.coinCounter)
                                        .resizable()
                                        .scaledToFit()
                                        .frame(width: 100)
                                    
                                    Text("1000")
                                        .font(.coinCounter)
                                        .appTextStyle()
                                        .padding(.leading, 8)
                                }
                            }
                        }
                        
                        .padding(.bottom, 32)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.mainOpaque)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.strokeMain, lineWidth: 2)
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .overlay(
                                VStack {
                                    Text("MENU")
                                        .font(.subtitle)
                                        .padding(.top, 56)
                                        .appTextStyle()
                                    
                                    Group {
                                        MainBtn(title: "PROFILE", action: {})
                                        
                                        MainBtn(title: "SETTINGS", action: {})
                                        
                                        MainBtn(title: "LEADERBOARD", action: {})
                                        
                                        MainBtn(title: "PRIVACY POLICY", action: {})
                                        
                                        MainBtn(title: "TERMS OF USE", action: {})
                                    }
                                    .frame(height: UIScreen.main.bounds.height * 0.11)
                                    .padding(.horizontal, UIScreen.main.bounds.width * 0.21)
                                },
                                alignment: .top
                            )
                    }
                    .padding(.horizontal, 32)
                }
            )
    }
}

#Preview {
    MenuView()
}
