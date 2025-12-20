//
//  LeaderBoardScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//


import Combine

@MainActor
final class LeaderBoardScreenVM: ObservableObject {
    @Published var profile = UserProfile()
    
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    
    func load() {
        if let loaded: UserProfile = profileSaver.getValue() {
            profile = loaded
        }
    }
}
