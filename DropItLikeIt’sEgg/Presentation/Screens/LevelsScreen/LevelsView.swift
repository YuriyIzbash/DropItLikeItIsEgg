//
//  LevelsView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct LevelsView: View {
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
                    VStack {
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
                        
                        Text("CHANGE LEVEL")
                            .font(.subtitle)
                            .appTextStyle()
                            .padding(.top, 16)
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 32)
                    
                }
            )
            .overlay(
                GridLevels()
                    .padding(.horizontal, 32)
            )
    }
}

private struct GridLevels: View {
    var body: some View {
        Grid(horizontalSpacing: 16, verticalSpacing: 24) {
            ForEach(0..<3, id: \.self) { row in
                GridRow {
                    ForEach(0..<3, id: \.self) { col in
                        let number = row * 3 + col + 1
                        let isLocked = number >= 7
                        SquareBtn(type: .empty, size: 96) {
                            if !isLocked {
                                print("Level \(number) tapped")
                            }
                        }
                        .overlay(
                            Text("\(number)")
                                .font(.subtitle)
                                .foregroundColor(.white)
                        )
                        .allowsHitTesting(!isLocked)
                        .grayscale(isLocked ? 1.0 : 0.0)
                    }
                }
            }
        }
        .frame(maxWidth: .infinity, maxHeight: .infinity, alignment: .center)
        .padding(.horizontal, 48)
    }
}

#Preview {
    LevelsView()
}
