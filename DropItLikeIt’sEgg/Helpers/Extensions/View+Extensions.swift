//
//  View+Extensions.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

extension View {
    func customFont(_ font: Font, color: Color? = .white, scaleFactor: CGFloat = 0.2) -> some View {
        self
            .modifier(FontModifier(font: font, color: color, scaleFactor: scaleFactor))
    }
    
    func customFont(_ fontType: FontType = .rubikMonoOneRegular, size: Double, color: Color? = .white, scaleFactor: CGFloat = 0.2) -> some View {
        self
            .customFont(.custom(fontType.fontName, size: size), color: color, scaleFactor: scaleFactor)
    }
}
