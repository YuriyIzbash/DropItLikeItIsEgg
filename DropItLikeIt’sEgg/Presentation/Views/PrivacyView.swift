//
//  PrivacyView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct PrivacyView: View {
    var body: some View {
        ZStackWithBackground {
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
                            Text("PRIVACY POLICY")
                                .customFont(size: 24)
                                .multilineTextAlignment(.center)
                            
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
    }
}

#Preview {
    PrivacyView()
}
