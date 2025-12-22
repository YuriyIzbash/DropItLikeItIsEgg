//
//  UserProfileService.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation

final class UserProfileService: DefaultsDataSaver<UserProfile> {
    init() {
        super.init(key: "user.profile")
    }
    
    func load() -> UserProfile? {
        super.getValue()
    }
    
    func save(_ profile: UserProfile) {
        super.save(profile)
    }
}
