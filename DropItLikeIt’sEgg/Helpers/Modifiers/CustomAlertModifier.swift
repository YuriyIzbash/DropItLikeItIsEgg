//
//  CustomAlertModifier.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import SwiftUI

struct CustomAlertModifier: ViewModifier {
    @Binding var isPresented: Bool
    
    let title: String
    let message: String
    let confirmTitle: String
    
    func body(content: Content) -> some View {
        ZStack {
            content
                .allowsHitTesting(!isPresented)
            
            if isPresented {
                CustomAlert(
                    title: title,
                    message: message,
                    confirmTitle: confirmTitle
                ) {
                    isPresented = false
                }
            }
        }
        .animation(.easeOut(duration: 0.25), value: isPresented)
    }
}
