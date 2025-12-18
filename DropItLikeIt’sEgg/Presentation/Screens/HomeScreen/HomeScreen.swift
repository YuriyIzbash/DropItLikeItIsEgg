//
//  HomeScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        Color.clear
            .edgesIgnoringSafeArea(.all)
            .background(
                ZStack {
                    Image("backgroundMain")
                        .resizable()
                        .scaledToFill()
                    
                    Image("chicken-1")
                        .resizable()
                        .scaledToFit()
                        .frame(width: UIScreen.main.bounds.width * 0.8, height: UIScreen.main.bounds.height)
                }
                    .ignoresSafeArea()
            )
            .overlay(
                ZStack {
                    HStack {
                        NavBtn(type: .info) {
                            print("Info tapped")
                        }
                        
                        Spacer()
                        
                        NavBtn(type: .menu) {
                            print("Info tapped")
                        }
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 32)
                    
                    MainBtn(title: "PLAY", action: {})
                        .frame(maxHeight: .infinity, alignment: .bottom)
                        .padding(.horizontal, 48)
                }
            )
    }
}

#Preview {
    HomeScreen()
}
