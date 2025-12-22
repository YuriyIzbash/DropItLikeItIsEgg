//
//  SettingsScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @StateObject var vm: SettingsScreenVM
    
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
        .customAlert(
            title: "Saved",
            message: "Your settings has been saved.",
            isPresented: $vm.showSaveConfirmation
        )
    }
    
    private var content: some View {
        VStack {
            settingsCard
            
            saveButton
                .padding(.bottom, 48)
        }
        .frame(maxHeight: .infinity, alignment: .bottom)
        .onAppear {
            vm.load()
        }
    }
}

private extension SettingsScreen {
    var settingsCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.appMain)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.appPink, lineWidth: 2)
            )
            .overlay(settingsContent, alignment: .center)
            .frame(maxWidth: .infinity)
            .padding(.horizontal, 16)
            .padding(.top, 80)

    }
    
    var settingsContent: some View {
        VStack {
            Text("SETTINGS")
                .customFont(size: 32)
            
            SettingToggleRow(title: "SOUND", isOn: $vm.soundIsOn)
            SettingToggleRow(title: "NOTIFICATION", isOn: $vm.notificationIsOn)
            SettingToggleRow(title: "VIBRATION", isOn: $vm.vibroIsOn)
        }
    }
    
    var saveButton: some View {
        MainBtn(title: "SAVE") {
            vm.save()
        }
        .padding(.top, 80)
    }
}

#Preview {
    SettingsScreen(vm: SettingsScreenVM())
}
