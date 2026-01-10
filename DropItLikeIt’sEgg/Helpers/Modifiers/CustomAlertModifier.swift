//
//  CustomAlertModifier.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import SwiftUI

struct CustomAlertModifier<State>: ViewModifier {
    @Binding var state: State?
    
    let title: String
    let message: String
    let confirmTitle: String
    
    private var isPresented: Bool { state != nil }
    
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
                    state = nil
                }
            }
        }
        .animation(.easeOut(duration: 0.25), value: isPresented)
    }
}

extension View {
    func customAlert<State>(
        state: Binding<State?>,
        title: String,
        message: String,
        confirmTitle: String = "OK"
    ) -> some View {
        modifier(
            CustomAlertModifier(
                state: state,
                title: title,
                message: message,
                confirmTitle: confirmTitle
            )
        )
    }
}
