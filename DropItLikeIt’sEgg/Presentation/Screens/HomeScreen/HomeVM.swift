//
//  HomeViewModel.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import SwiftUI

@MainActor
final class HomeVM: BaseModel {
    // MARK: - Navigation
    func openInfo() {
        push(.info)
    }
    
    func openMenu() {
        push(.menu)
    }
    
    func openLevels() {
        push(.levels)
    }
}
