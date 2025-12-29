//
//  LevelsScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct LevelsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: LevelsScreenVM
    
    var body: some View {
        ZStackWithBackground {
            Text("CHANGE LEVEL")
                .customFont(size: 32)
                .lineLimit(1)
                .padding(.top, 16)
                .frame(maxHeight: .infinity, alignment: .top)
                .padding(.horizontal, 48)
            
            GridLevels(vm: vm)
                .padding(.top, 48)
        }
        .topBar(
            leading: {
                NavBtn(type: .back, action: dismiss.callAsFunction)
            },
            trailing: {
                CoinCounterView(amount: vm.coinAmount, action: vm.openShop)
            }
        )
        .onAppear {
            vm.load()
        }
    }
}

#Preview {
    LevelsScreen(vm: .init(appVM: ContentVM(Services.shared), services: Services.shared))
}
