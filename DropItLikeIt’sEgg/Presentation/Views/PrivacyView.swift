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
            VStack {
                RoundedRectangle(cornerRadius: 8)
                    .fill(Color.appMain)
                    .overlay(
                        RoundedRectangle(cornerRadius: 8)
                            .stroke(Color.appPink, lineWidth: 2)
                    )
                    .frame(maxWidth: .infinity)
                    .overlay(alignment: .top) {
                        VStack {
                            Text("PRIVACY POLICY")
                                .customFont(size: 24)
                                .multilineTextAlignment(.center)
                            
                            Text("TEXT")
                                .customFont(size: 12)
                                .frame(maxHeight: .infinity)
                        }
                        .padding(16)
                    }
            }
            .padding(32)
        }
        .topBackBar()
    }
}

#Preview {
    PrivacyView()
}
