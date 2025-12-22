//
//  BlastView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import SwiftUI

struct BlastView: View {
    let blast: GameScreenVM.Blast
    let size: CGSize

    @State private var scale: CGFloat = 0.2
    @State private var opacity: Double = 1.0

    var body: some View {
        Image(.blast)
            .resizable()
            .scaledToFit()
            .frame(width: 80, height: 80)
            .scaleEffect(scale)
            .opacity(opacity)
            .position(
                x: blast.x * size.width,
                y: blast.y
            )
            .task {
                withAnimation(.spring(response: 0.35, dampingFraction: 0.75)) {
                    scale = 1.0
                }
            }
    }
}
