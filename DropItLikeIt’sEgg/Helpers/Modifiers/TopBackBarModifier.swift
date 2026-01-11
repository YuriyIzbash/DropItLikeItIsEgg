//
//  TopBackBarModifier.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 29. 12. 25.
//

import SwiftUI

struct TopBackBarModifier: ViewModifier {
    @Environment(\.dismiss) private var dismiss
    
    func body(content: Content) -> some View {
        content
            .topBar(
                leading: {
                    NavBtn(type: .back, action: dismiss.callAsFunction)
                },
                trailing: {
                    EmptyView()
                }
            )
    }
}

extension View {
    func topBackBar() -> some View {
        modifier(TopBackBarModifier())
    }
}
