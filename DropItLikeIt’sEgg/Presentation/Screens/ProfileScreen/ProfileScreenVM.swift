//
//  ProfileScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 19. 12. 25.
//

import Combine
import UIKit

@MainActor
final class ProfileScreenVM: BaseModel {
    @Published var editableProfile: UserProfile = UserProfile()
    @Published var showSaveConfirmation: Bool = false
    @Published var showPhotoActionSheet: Bool = false
    @Published var showCameraPicker: Bool = false
    @Published var showPhotoPicker: Bool = false
    @Published private(set) var usernameError: Bool = false
    @Published private(set) var emailError: Bool = false
    
    override init(_ services: Services) {
        super.init(services)
        
        editableProfile = userProfileService.profile
    }
    
    enum Field: Hashable {
        case username
        case email
    }
    
    func save() -> Field? {
        let isUsernameEmpty = editableProfile.username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        let isEmailEmpty = editableProfile.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
        
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
        
        if editableProfile.image == nil {
            editableProfile.image = UIImage(named: "profilePlaceholder")
        }
        
        userProfileService.profile = editableProfile
        
        return nil
    }
    
    func saveOnDisappear() {
        if !editableProfile.username.isEmpty && !editableProfile.email.isEmpty {
            userProfileService.profile = editableProfile
        }
    }
}

