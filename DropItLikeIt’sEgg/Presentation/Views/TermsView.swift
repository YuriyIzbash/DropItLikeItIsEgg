//
//  TermsView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct TermsView: View {
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
                        NavBtn(type: .back) {
                            print("Back tapped")
                        }
                        .padding(.bottom, 8)
                        
                        RoundedRectangle(cornerRadius: 8)
                            .fill(Color.appMain)
                            .overlay(
                                RoundedRectangle(cornerRadius: 8)
                                    .stroke(Color.appPink, lineWidth: 2)
                            )
                            .frame(maxWidth: .infinity, alignment: .center)
                            .overlay(
                                VStack {
                                    Text("TERMS OF USE")
                                        .customFont(size: 24)
                                        .multilineTextAlignment(.center)
                                        .minimumScaleFactor(0.6)
                                        .lineLimit(1)
                                    
                                    Text("TEXT")
                                        .customFont(size: 12)
                                        .frame(maxHeight: .infinity, alignment: .center)
                                }
                                    .padding(16),
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
    TermsView()
}
