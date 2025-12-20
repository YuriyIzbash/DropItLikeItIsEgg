//
//  HomeScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct HomeScreen: View {
    @EnvironmentObject private var appVM: ContentVM
    
    var body: some View {
        ZStackWithBackground {
            Image(.chicken1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 48)
                .padding(.top, 32)
            
            MainBtn(title: "PLAY", action: { appVM.openLevels() })
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal, 56)
                .padding(.bottom, 32)
        }
        .safeAreaInset(edge: .top) {
            HStack {
                NavBtn(type: .info) { appVM.openInfo() }
                
                Spacer()
                
                NavBtn(type: .menu) { appVM.openMenu() }
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
        }
    }
}

#Preview {
    HomeScreen()
}
