//
//  CustomAlert.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import SwiftUI

struct CustomAlert: View {
    let title: String
    let message: String
    let confirmTitle: String
    let onConfirm: () -> Void
    
    var body: some View {
        ZStack {
            Color.black.opacity(0.5)
                .ignoresSafeArea()
                .onTapGesture {
                    onConfirm()
                }
            
            VStack(spacing: 16) {
                Text(title)
                    .font(.headline)
                
                Text(message)
                    .font(.body)
                    .multilineTextAlignment(.center)
                
                Button(confirmTitle) {
                    onConfirm()
                }
                .padding(.top, 8)
            }
            .padding(24)
            .background(.white.opacity(0.95))
            .cornerRadius(16)
            .shadow(radius: 20)
            .padding(.horizontal, 40)
            .accessibilityAddTraits(.isModal)
        }
        .transition(.opacity.combined(with: .scale))
    }
}

