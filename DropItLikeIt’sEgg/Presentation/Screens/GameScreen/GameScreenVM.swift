//
//  GameScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import Combine

@MainActor
final class GameScreenVM: ObservableObject {
    @Published var isPaused: Bool = false
    
    func togglePause() {
        isPaused.toggle()
    }
    
    func pause() {
        isPaused = true
    }
    
    func resume() {
        isPaused = false
    }
}
