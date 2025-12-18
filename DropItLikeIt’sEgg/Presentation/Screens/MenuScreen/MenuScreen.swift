//
//  MenuScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct MenuScreen: View {
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
                            NavBtn(type: .back) {
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
                                        .customFont(size: 12)
                                        .padding(.leading, 8)
                                }
                            }
                        }
                        
                        .padding(.bottom, 32)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.appMain)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.appPink, lineWidth: 2)
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .overlay(
                                VStack {
                                    Text("MENU")
                                        .customFont(size: 32)
                                        .padding(.top, 56)
                                    
                                    Group {
                                        MainBtn(title: "PROFILE", action: {})
                                        
                                        MainBtn(title: "SETTINGS", action: {})
                                        
                                        MainBtn(title: "LEADER BOARD", action: {})
                                        
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
    MenuScreen()
}
