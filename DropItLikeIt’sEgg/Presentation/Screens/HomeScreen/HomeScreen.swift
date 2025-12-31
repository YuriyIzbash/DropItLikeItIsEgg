//
//  HomeScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

struct HomeScreen: View {
    @StateObject private var vm: HomeVM
    @State private var showProgress = true
    
    init(services: Services) {
        _vm = StateObject(wrappedValue: HomeVM(services))
    }
    
    var body: some View {
        ZStackWithBackground {
            Image(.chicken1)
                .resizable()
                .scaledToFit()
                .frame(maxWidth: .infinity)
                .padding(.horizontal, 48)
                .padding(.top, 32)
            
            MainBtn(title: "PLAY", action: { vm.openLevels() })
                .frame(maxWidth: .infinity, alignment: .center)
                .frame(maxHeight: .infinity, alignment: .bottom)
                .padding(.horizontal, 56)
                .padding(.bottom, 32)
        }
        .topBar(
            leading: {
                NavBtn(type: .info) { vm.openInfo()}
            },
            trailing: {
                NavBtn(type: .menu) { vm.openMenu() }
            }
        )
        .overlay {
            if showProgress {
                CustomProgressView(onFinished: {
                    withAnimation(.easeInOut(duration: 0.35)) {
                        showProgress = false
                    }
                })
                .transition(.opacity)
            }
        }
        .animation(.easeInOut(duration: 0.35), value: showProgress)
    }
}

#Preview {
    HomeScreen(services: Services.shared)
}
