//
//  CoinCounterView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import SwiftUI

struct CoinCounterView: View {
    let amount: Int

    var body: some View {
        ZStack(alignment: .center) {
            Image(.coinCounter)
                .resizable()
                .scaledToFit()
                .frame(height: 64)

            Text("\(amount)")
                .customFont(size: 12)
                .padding(.leading, -56)
        }
    }
}

#Preview {
    CoinCounterView(amount: 1000)
}
