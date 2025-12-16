//
//  TextOutlineModifier.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

fileprivate struct TextOutlineModifier: ViewModifier {
    let width: CGFloat
    let color: Color

    func body(content: Content) -> some View {
        ZStack {
            outline(content)
            content
        }
        .compositingGroup()
    }

    @ViewBuilder
    private func outline(_ content: Content) -> some View {
        ForEach(offsets.indices, id: \.self) { index in
            let offset = offsets[index]
            content
                .foregroundColor(color)
                .offset(x: offset.width, y: offset.height)
        }
    }

    private var offsets: [CGSize] {
        let w = width
        return [
            .init(width: -w, height: 0),
            .init(width:  w, height: 0),
            .init(width: 0, height: -w),
            .init(width: 0, height:  w),
            .init(width: -w, height: -w),
            .init(width: -w, height:  w),
            .init(width:  w, height: -w),
            .init(width:  w, height:  w)
        ]
    }
}

extension View {
    func textOutline(
        width: CGFloat = 3,
        color: Color = .textOutline
    ) -> some View {
        modifier(TextOutlineModifier(width: width, color: color))
    }
}
