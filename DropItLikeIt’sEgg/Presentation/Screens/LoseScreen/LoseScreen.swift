//
//  LoseScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct LoseScreen: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 24) {
                    Text("YOU LOSE!")
                        .customFont(size: 32)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    
                    VStack {
                        ScoreRow(title: "SCORE", value: "0000")
                        ScoreRow(title: "BEST", value: "0000")
                    }
                    
                    Button {
                        print("Home tapped ...")
                    } label: {
                        Text("HOME")
                            .customFont(size: 24)
                            .underline(true)
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.horizontal, 32)
                
                MainBtn(title: "TRY AGAIN", action: {
                    print("TRY AGAIN tapped...")
                })
                .padding(.horizontal, 48)
            }
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
    }
}

#Preview {
    LoseScreen()
}
