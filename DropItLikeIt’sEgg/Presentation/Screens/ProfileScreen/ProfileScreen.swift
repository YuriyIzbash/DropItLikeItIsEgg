//
//  ProfileScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct ProfileScreen: View {
    @State private var profile = UserProfile()
    @FocusState private var focusedField: Field?
    @State private var showPhotoActionSheet: Bool = false
    @State private var showCameraPicker: Bool = false
    @State private var showPhotoPicker: Bool = false
    @State private var usernameError: Bool = false
    @State private var emailError: Bool = false
    
    private let profileSaver = DefaultsDataSaver<UserProfile>(key: "user.profile")
    
    enum Field: Hashable {
        case username
        case email
    }
    
    var body: some View {
        ZStack {
            MainBackground()
            content
        }
        .overlay {
            if showPhotoActionSheet {
                PhotoActionSheet(
                    isPresented: $showPhotoActionSheet,
                    onMakePhoto: { showCameraPicker = true },
                    onChoosePhoto: { showPhotoPicker = true }
                )
            }
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
            header
            profileCard
            saveButton
        }
        .padding(.horizontal, 32)
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            if let loaded: UserProfile = profileSaver.getValue() {
                profile = loaded
            }
        }
    }
}

private extension ProfileScreen {
    var header: some View {
        NavBtn(type: .back) {
            print("Back tapped")
        }
        .padding(.bottom, 32)
    }
    
    var profileCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.appMain)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.appPink, lineWidth: 2)
            )
            .overlay(profileContent, alignment: .top)
            .padding(.horizontal, 32)
    }
    
    var profileContent: some View {
        VStack(spacing: 0) {
            Text("PROFILE")
                .customFont(size: 32)
                .padding(.top, 56)
            
            avatarButton
                .padding(.top, 16)
            
            StyledTextField(
                title: "USERNAME",
                text: $profile.username,
                field: .username,
                focusedField: $focusedField,
                isError: usernameError
            )
            .padding(.top, 12)
            
            StyledTextField(
                title: "EMAIL",
                text: $profile.email,
                field: .email,
                focusedField: $focusedField,
                isError: emailError
            )
            .padding(.top, 8)
        }
        .padding(.horizontal, 24)
    }
    
    var avatarButton: some View {
        ZStack {
            if let image = profile.image {
                Image(uiImage: image)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 120, height: 120)
                    .clipShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .overlay(
                        RoundedRectangle(cornerRadius: 8, style: .continuous)
                            .stroke(Color.appPink, lineWidth: 2)
                    )
                    .contentShape(RoundedRectangle(cornerRadius: 8, style: .continuous))
                    .onTapGesture { showPhotoActionSheet = true }
            } else {
                NavBtn(type: .empty, size: 120) {
                    showPhotoActionSheet = true
                }
            }
        }
        .overlay(
            Image(systemName: "square.and.pencil")
                .foregroundStyle(Color.white)
                .padding(3)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.appLightGreen)
                ),
            alignment: .bottom
        )
        .sheet(isPresented: $showCameraPicker) {
            ImagePicker(sourceType: .camera, selectedImage: $profile.image)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $showPhotoPicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $profile.image)
                .ignoresSafeArea()
        }
    }
    
    var saveButton: some View {
        MainBtn(title: "SAVE") {
            let isUsernameEmpty = profile.username.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty
            let isEmailEmpty = profile.email.trimmingCharacters(in: .whitespacesAndNewlines).isEmpty

            usernameError = isUsernameEmpty
            emailError = isEmailEmpty

            guard !isUsernameEmpty && !isEmailEmpty else {
                if isUsernameEmpty {
                    focusedField = .username
                } else if isEmailEmpty {
                    focusedField = .email
                }
                return
            }

            if profile.image == nil {
                profile.image = UIImage(named: "chicken-1")
            }

            profileSaver.save(profile)
        }
        .frame(height: 140)
        .padding(.horizontal, 48)
    }
}

private struct StyledTextField: View {
    let title: String
    @Binding var text: String
    let field: ProfileScreen.Field
    @FocusState.Binding var focusedField: ProfileScreen.Field?
    var isError: Bool = false
    
    var body: some View {
        ZStack {
            RoundedRectangle(cornerRadius: 8, style: .continuous)
                .fill(Color.appPink)
            
            HStack(spacing: 12) {
                ZStack(alignment: .leading) {
                    if text.isEmpty && focusedField != field {
                        Text(title)
                            .customFont(size: 16)
                            .foregroundStyle(isError ? Color.red : Color.white)
                    }
                    
                    TextField("", text: $text)
                        .textInputAutocapitalization(.never)
                        .autocorrectionDisabled(true)
                        .customFont(size: 16)
                        .tint(.white)
                        .focused($focusedField, equals: field)
                }
                
                Image(systemName: "square.and.pencil")
                    .foregroundStyle(Color.white.opacity(0.9))
            }
            .padding(.horizontal, 14)
            .padding(.vertical, 12)
        }
        .frame(height: 48)
    }
}

private struct MainBackground: View {
    var body: some View {
        Image("backgroundMain")
            .resizable()
            .scaledToFill()
            .ignoresSafeArea()
    }
}

#Preview {
    ProfileScreen()
}
