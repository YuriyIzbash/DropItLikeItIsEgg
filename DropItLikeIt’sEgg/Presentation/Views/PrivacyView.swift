//
//  PrivacyView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct PrivacyView: View {
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
                    VStack(alignment: .leading) {
                        SquareBtn(type: .back) {
                            print("Back tapped")
                        }
                        .padding(.bottom, 8)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.mainOpaque)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.strokeMain, lineWidth: 2)
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .overlay(
                                VStack {
                                    Text("PRIVACY POLICY")
                                        .font(.subtitle)
                                        .multilineTextAlignment(.center)
                                    Text("TEXT")
                                        .font(.regularText)
                                        .frame(maxHeight: .infinity, alignment: .center)
                                }
                                    .padding(16)
                                    .appTextStyle(),
                                alignment: .top
                            )
                    }
                    .frame(maxHeight: .infinity, alignment: .top)
                    .padding(.horizontal, 32)
                }
            )
    }
}

#Preview {
    PrivacyView()
}
