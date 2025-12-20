//
//  LevelsScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct LevelsScreen: View {
    @Environment(\.dismiss) private var dismiss
    
    var body: some View {
        ZStackWithBackground {
                VStack {
                    HStack {
                        NavBtn(type: .back) { dismiss() }
                        
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
                    
                    Text("CHANGE LEVEL")
                        .customFont(size: 32)
                        .padding(.top, 16)
                }
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 48)
            
            GridLevels()
        }
        .padding(.horizontal, 32)
    }
}

struct GridLevels: View {
    @EnvironmentObject private var appVM: ContentVM
    
    var body: some View {
        Grid(horizontalSpacing: 16, verticalSpacing: 24) {
            ForEach(0..<3, id: \.self) { row in
                GridRow {
                    ForEach(0..<3, id: \.self) { col in
                        let number = row * 3 + col + 1
                        let isLocked = number >= 7
                        NavBtn(type: .empty, size: 96) {
                            if !isLocked {
                                appVM.openGame()
                            }
                        }
                        .overlay(
                            Text("\(number)")
                                .customFont(size: 32)
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
    LevelsScreen()
}
