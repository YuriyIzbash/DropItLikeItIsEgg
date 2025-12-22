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
        .safeAreaInset(edge: .top) {
            HStack {
                NavBtn(type: .back) { dismiss() }
                
                Spacer()
            }
            .padding(.horizontal, 32)
            .padding(.top, 16)
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
        VStack(spacing: 12) {
            profileCard
            
            saveButton
        }
        .padding(.top, 24)
        .onDisappear {
            vm.saveOnDisappear()
        }
    }
}

private extension ProfileScreen {
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
        .overlay(alignment: .bottom) {
            Image(systemName: "square.and.pencil")
                .foregroundStyle(Color.white)
                .padding(3)
                .background(
                    RoundedRectangle(cornerRadius: 6, style: .continuous)
                        .fill(Color.appLightGreen)
                )
        }
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
    }
}

#Preview {
    ProfileScreen(vm: ProfileScreenVM(Services.shared))
}
