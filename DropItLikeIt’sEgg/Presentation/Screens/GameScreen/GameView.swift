//
//  GameView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct GameView: View {
    var body: some View {
        Color.clear
            .edgesIgnoringSafeArea(.all)
            .background(
                ZStack {
                    Image("backgroundGame")
                        .resizable()
                        .scaledToFill()
                    
                }
                    .ignoresSafeArea()
            )
            .overlay(
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
                    .frame(maxWidth: .infinity, alignment: .center)
                    
                    
                    SquareBtn(type: .pause) {
                        print("Pause tapped")
                    }
                }
                    .padding(.horizontal, 32)
                , alignment: .top
            )
    }
}

#Preview {
    GameView()
}
