//
//  MenuScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct MenuScreen: View {
    var body: some View {
        GeometryReader { proxy in
            ZStackWithBackground {
                
            }
            .overlay(alignment: .center) {
                VStack {
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
                        .offset(x: -30)
                    }
                    .padding(.bottom, 56)
                    .padding(.horizontal, 24)
                    
                    VStack {
                        Text("MENU")
                            .customFont(size: 32)
                            .padding(.vertical, 16)
                        
                        Group {
                            MainBtn(title: "PROFILE", action: {})
                            
                            MainBtn(title: "SETTINGS", action: {})
                            
                            MainBtn(title: "LEADER BOARD", action: {})
                            
                            MainBtn(title: "PRIVACY POLICY", action: {})
                            
                            MainBtn(title: "TERMS OF USE", action: {})
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
