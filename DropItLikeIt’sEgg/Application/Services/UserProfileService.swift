//
//  UserProfileService.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Combine

@MainActor
final class UserProfileService: ObservableObject {
    @PublishedStored(key: "user.profile") 
    var profile = UserProfile()
}
