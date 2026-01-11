//
//  View+Extensions.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

// MARK: - CustomFont
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

// MARK: - CustomAlert
extension View {
    func customAlert(
        title: String,
        message: String,
        confirmTitle: String = "OK",
        isPresented: Binding<Bool>
    ) -> some View {
        let stateBinding: Binding<Bool?> = Binding<Bool?>(
            get: { isPresented.wrappedValue ? true : nil },
            set: { newValue in isPresented.wrappedValue = (newValue != nil) }
        )
        return modifier(
            CustomAlertModifier(
                state: stateBinding,
                title: title,
                message: message,
                confirmTitle: confirmTitle
            )
        )
    }
}

