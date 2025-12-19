//
//  WinScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct WinScreen: View {
    var body: some View {
        ZStackWithBackground(color: .black.opacity(0.8)) {
            VStack {
                Spacer()
                
                VStack(spacing: 24) {
                    Text("YOU WIN!")
                        .customFont(size: 32)
                        .minimumScaleFactor(0.7)
                        .lineLimit(1)
                    
                    VStack {
                        ScoreRow(title: "SCORE", value: "0000")
                        ScoreRow(title: "BEST", value: "0000")
                    }
                    
                    HStack {
                        Button {
                            print("Home tapped ...")
                        } label: {
                            Text("HOME")
                                .customFont(size: 24)
                                .underline(true)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Restart tapped ...")
                        } label: {
                            Text("RESTART")
                                .customFont(size: 24)
                                .underline(true)
                        }
                    }
                    .padding(.horizontal, 12)
                }
                .padding(.horizontal, 32)
                
                MainBtn(title: "NEXT", action: {
                    print("NEXT tapped...")
                })
                .padding(.horizontal, 48)
            }
        }
    }
}

struct ScoreRow: View {
    let title: String
    let value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.appLightGreen)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.appGreen, lineWidth: 2)
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 60)
            
            HStack(spacing: 18) {
                Text(title)
                Spacer()
                Text(value)
            }
            .padding(.horizontal, 18)
            .customFont(size: 24)
        }
    }
}

#Preview {
    WinScreen()
}
