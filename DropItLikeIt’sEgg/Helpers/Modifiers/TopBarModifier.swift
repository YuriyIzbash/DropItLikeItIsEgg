//
//  TopBarModifier.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 29. 12. 25.
//


import SwiftUI

struct TopBarModifier<Leading: View, Trailing: View>: ViewModifier {
    @ViewBuilder var leading: () -> Leading
    @ViewBuilder var trailing: () -> Trailing
    
    func body(content: Content) -> some View {
        content
            .safeAreaInset(edge: .top) {
                ZStack {
                    leading()
                        .frame(maxWidth: .infinity, alignment: .leading)
                    
                    trailing()
                        .frame(maxWidth: .infinity, alignment: .trailing)
                }
                .padding(.horizontal, 32)
                .padding(.top, 16)
            }
    }
}

extension View {
    func topBar<Leading: View, Trailing: View>(
        @ViewBuilder leading: @escaping () -> Leading,
        @ViewBuilder trailing: @escaping () -> Trailing
    ) -> some View {
        modifier(TopBarModifier(leading: leading, trailing: trailing))
    }
}
