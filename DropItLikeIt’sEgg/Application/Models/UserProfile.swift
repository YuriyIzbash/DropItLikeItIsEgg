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
    var score: Int
    @StoredImage(in: "ProfileImages") var image: UIImage?

    init(
        username: String = "",
        email: String = "",
        score: Int = 0,
        image: UIImage = UIImage(imageLiteralResourceName: "profilePlaceholder")
    ) {
        self.username = username
        self.email = email
        self.score = score
        self._image = StoredImage(wrappedValue: image, in: "ProfileImages")
    }
}
