//
//  HomeScreenVM.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import Combine
import SwiftUI

@MainActor
final class HomeScreenVM: ObservableObject {
    @Published var path: [AppRoute] = []
    
    func openInfo() {
        path.append(.info)
    }
    
    func openMenu() {
        path.append(.menu)
    }
    
    func openGame() {
        path.append(.game(level: 1))
    }
}
