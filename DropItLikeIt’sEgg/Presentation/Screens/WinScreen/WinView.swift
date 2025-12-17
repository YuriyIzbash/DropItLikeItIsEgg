//
//  WinView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct WinView: View {
    var body: some View {
        ZStack(alignment: .bottom) {
            Color.black.opacity(0.8)
                .ignoresSafeArea()
            
            VStack {
                VStack(spacing: 24) {
                    Text("YOU WIN!")
                        .font(.title2)
                        .appTextStyle()
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
                                .font(.subtitle)
                                .appTextStyle()
                                .underline(true)
                        }
                        
                        Spacer()
                        
                        Button {
                            print("Restart tapped ...")
                        } label: {
                            Text("RESTART")
                                .font(.subtitle)
                                .appTextStyle()
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
            .frame(maxWidth: .infinity, alignment: .bottom)
        }
    }
}

struct ScoreRow: View {
    let title: String
    let value: String
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 12)
                .fill(Color.scoreBackground)
                .overlay(
                    RoundedRectangle(cornerRadius: 12)
                        .stroke(Color.scoreOutline, lineWidth: 2)
                )
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(height: 60)
            
            HStack(spacing: 18) {
                Text(title)
                Spacer()
                Text(value)
            }
            .padding(.horizontal, 18)
            .font(.subtitle)
            .appTextStyle()
        }
    }
}

#Preview {
    WinView()
}
