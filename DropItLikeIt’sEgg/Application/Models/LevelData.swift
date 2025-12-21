//
//  LevelData.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 21. 12. 25.
//

import Foundation

struct LevelData: Identifiable {
    let id = UUID()
    let number: Int
    let isLocked: Bool
}
