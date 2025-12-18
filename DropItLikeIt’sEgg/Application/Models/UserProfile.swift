//
//  UserProfile.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import UIKit

struct UserProfile: Codable, Equatable {
    var username: String
    var email: String
    @StoredImage(in: "ProfileImages") var image: UIImage?

    init(
        username: String = "",
        email: String = "",
        image: UIImage? = nil
    ) {
        self.username = username
        self.email = email
        self._image = StoredImage(wrappedValue: image, in: "ProfileImages")
    }
}
