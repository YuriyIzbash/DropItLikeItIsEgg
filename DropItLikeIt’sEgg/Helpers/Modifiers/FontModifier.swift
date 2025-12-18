//
//  FontModifier.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

enum FontType {
    case rubikMonoOneRegular
    case fredokaSemiBold
    
    var fontName: String {
        switch self {
        case .rubikMonoOneRegular:
            return "RubikMonoOne-Regular"
        case .fredokaSemiBold:
            return "Fredoka-SemiBold"
        }
    }
}

struct FontModifier: ViewModifier {
    let font: Font
    let color: Color?
    let scaleFactor: CGFloat
    
    func body(content: Content) -> some View {
        if let color = color {
            content
                .font(font)
                .foregroundColor(color)
                .minimumScaleFactor(scaleFactor)
        } else {
            content
                .font(font)
                .minimumScaleFactor(scaleFactor)
        }
    }
}
