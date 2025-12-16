//
//  HomeView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct HomeView: View {
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
                VStack() {
                    Spacer()
                    
                    MainBtn(title: "PLAY", action: {})
                        .padding(.horizontal, 48)
                }
            )
    }
}

#Preview {
    HomeView()
}
