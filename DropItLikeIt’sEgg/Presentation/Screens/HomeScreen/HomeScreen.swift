//
//  HomeScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct HomeScreen: View {
    var body: some View {
        GeometryReader { proxy in
            ZStackWithBackground {
                Image(.chicken1)
                    .resizable()
                    .scaledToFit()
                    .frame(width: proxy.size.width * 0.8, height: proxy.size.height)
            }
            .overlay {
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
            }
        }
    }
}

#Preview {
    HomeScreen()
}
