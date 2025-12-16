//
//  MainBtn.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct MainBtn: View {
    var title: String
    var action: () -> Void
    
    var body: some View {
        Button(action: action) {
            HStack {
                Text(title)
                    .frame(maxWidth: .infinity, alignment: .center)
                    .font(.mainBtn)
                    .textOutline(width: 1, color: .textOutline)
                    .foregroundColor(.white)
            }
            .frame(height: 347)
            .background(
                Image("btnMain")
                    .resizable()
                    .scaledToFit()
            )
        }
        .buttonStyle(PlainButtonStyle())
    }
}

#Preview {
    MainBtn(title: "Test") {
        print("Tested...")
    }
}
