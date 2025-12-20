//
//  ProfileScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 17. 12. 25.
//

import SwiftUI

struct ProfileScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: ProfileScreenVM
    @FocusState private var focusedField: ProfileScreenVM.Field?
    
    var body: some View {
        ZStackWithBackground {
            content
        }
        .overlay {
            if vm.showPhotoActionSheet {
                PhotoActionSheet(
                    isPresented: $vm.showPhotoActionSheet,
                    onMakePhoto: { vm.showCameraPicker = true },
                    onChoosePhoto: { vm.showPhotoPicker = true }
                )
            }
        }
        .customAlert(
            title: "Saved",
            message: "Your profile has been saved.",
            isPresented: $vm.showSaveConfirmation
        )
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
            vm.load()
        }
    }
}

private extension ProfileScreen {
    var header: some View {
        NavBtn(type: .back) { dismiss() }
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
                text: $vm.profile.username,
                field: .username,
                focusedField: $focusedField,
                isError: vm.usernameError
            )
            .padding(.top, 12)
            
            StyledTextField(
                title: "EMAIL",
                text: $vm.profile.email,
                field: .email,
                focusedField: $focusedField,
                isError: vm.emailError
            )
            .padding(.top, 8)
        }
        .padding(.horizontal, 24)
    }
    
    var avatarButton: some View {
        ZStack {
            if let image = vm.profile.image {
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
                    .onTapGesture { vm.showPhotoActionSheet = true }
            } else {
                NavBtn(type: .empty, size: 120) {
                    vm.showPhotoActionSheet = true
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
        .sheet(isPresented: $vm.showCameraPicker) {
            ImagePicker(sourceType: .camera, selectedImage: $vm.profile.image)
                .ignoresSafeArea()
        }
        .sheet(isPresented: $vm.showPhotoPicker) {
            ImagePicker(sourceType: .photoLibrary, selectedImage: $vm.profile.image)
                .ignoresSafeArea()
        }
    }
    
    var saveButton: some View {
        MainBtn(title: "SAVE") {
            let fieldToFocus = vm.save()
            if let field = fieldToFocus {
                focusedField = field
            } else {
                vm.showSaveConfirmation = true
            }
        }
        .frame(height: 140)
        .padding(.horizontal, 48)
    }
}

private struct StyledTextField: View {
    let title: String
    @Binding var text: String
    let field: ProfileScreenVM.Field
    @FocusState.Binding var focusedField: ProfileScreenVM.Field?
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

#Preview {
    ProfileScreen(vm: ProfileScreenVM())
}
