//
//  InfoView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct InfoView: View {
    @Environment(\.dismiss) private var dismiss
    @EnvironmentObject private var appVM: ContentVM
    
    var body: some View {
        ZStackWithBackground {
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.appMain)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appPink, lineWidth: 2)
                    )
                    .frame(maxWidth: .infinity, alignment: .center)
                    .overlay(
                        VStack {
                            Text("HOW TO PLAY")
                                .customFont(size: 24)
                            
                            Text("""
                                1. 
                                Catch falling eggs by moving chicken left and right. 
                                
                                2. 
                                Each caught egg earns you 10 points, but missing an egg costs you 100 points!
                                
                                3. 
                                Grab coins for bonus points (20, 30, or 50 each). 
                                
                                4. 
                                Catch all the eggs to win the level!
                                """)
                                .customFont(size: 16)
                                .multilineTextAlignment(.center)
                                .frame(maxHeight: .infinity, alignment: .center)
                        }
                            .padding(16),
                        alignment: .top
                    )
            }
            .padding(32)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                NavBtn(type: .back) { dismiss() }
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
    }
}

#Preview {
    InfoView()
}

