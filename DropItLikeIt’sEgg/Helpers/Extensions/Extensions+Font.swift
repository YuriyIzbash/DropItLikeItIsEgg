//
//  Extensions+Font.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

extension Font {
    enum Family {
        static let rubikMonoOne = "RubikMonoOne-Regular"
        static let fredoka = "Fredoka-VariableFont_wdth,wght"
    }
    
    static let title: Font = .custom(Family.rubikMonoOne, size: 56)
    static let title2: Font = .custom(Family.rubikMonoOne, size: 48)
    static let subtitle: Font = .custom(Family.rubikMonoOne, size: 26)
    static let coinCounter: Font = .custom(Family.rubikMonoOne, size: 12)
    static let mainBtn: Font = .custom(Family.rubikMonoOne, size: 56)
    static let menuBtn: Font = .custom(Family.rubikMonoOne, size: 35)
    static let mainText: Font = .custom(Family.rubikMonoOne, size: 24)
    static let regularText: Font = .custom(Family.rubikMonoOne, size: 12)
    
    static let sheetText: Font = .custom(Family.fredoka, size: 37.5)
}

#Preview {
    Text("test")
        .font(.title)
    
    Text("test")
        .font(.title2)
    
    Text("test")
        .font(.subtitle)
    
    Text("test")
        .font(.coinCounter)
    
    Text("test")
        .font(.mainBtn)
    
    Text("test")
        .font(.menuBtn)
    
    Text("test")
        .font(.mainText)
    
    Text("test")
        .font(.regularText)
    
    Text("test")
        .font(.sheetText)
}
