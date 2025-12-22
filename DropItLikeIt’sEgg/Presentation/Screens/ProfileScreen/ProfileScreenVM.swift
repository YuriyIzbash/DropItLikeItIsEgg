//
//  ProfileScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import Combine
import UIKit

final class ProfileScreenVM: BaseModel {
    @Published var profile = UserProfile()
    @Published var showSaveConfirmation: Bool = false
    @Published var showPhotoActionSheet: Bool = false
    @Published var showCameraPicker: Bool = false
    @Published var showPhotoPicker: Bool = false
    @Published var usernameError: Bool = false
    @Published var emailError: Bool = false
    
    override init(_ services: Services) {
        super.init(services)
        load()
    }
    
    enum Field: Hashable {
        case username
        case email
    }
    
    func load() {
        if let loaded = userProfileService.load() {
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
        
        userProfileService.save(profile)
        return nil
    }
    
    func saveOnDisappear() {
        userProfileService.save(profile)
    }
}

