//
//  ProfileScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import Combine
import UIKit

@MainActor
final class ProfileScreenVM: ObservableObject {
    @Published var profile = UserProfile()
    @Published var showSaveConfirmation: Bool = false
    @Published var showPhotoActionSheet: Bool = false
    @Published var showCameraPicker: Bool = false
    @Published var showPhotoPicker: Bool = false
    @Published var usernameError: Bool = false
    @Published var emailError: Bool = false
    
    enum Field: Hashable {
        case username
        case email
    }
    
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    
    func load() {
        if let loaded: UserProfile = profileSaver.getValue() {
            profile = loaded
        }
    }
    
    func save() -> Field? {
        let isUsernameEmpty = profile.username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isEmailEmpty = profile.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
        usernameError = isUsernameEmpty
        emailError = isEmailEmpty
        
        guard !isUsernameEmpty && !isEmailEmpty else {
            if isUsernameEmpty {
                return .username
            } else if isEmailEmpty {
                return .email
            }
            return nil
        }
        
        if profile.image == nil {
            profile.image = UIImage(named: "profilePlaceholder")
        }
        
        profileSaver.save(profile)
        return nil
    }
}

