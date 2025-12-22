//
//  PrivacyView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct PrivacyView: View {
    @Environment(\.dismiss) private var dismiss
    
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
    PrivacyView()
}
