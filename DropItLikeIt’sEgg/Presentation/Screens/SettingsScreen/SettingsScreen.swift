//
//  SettingsScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

struct SettingsScreen: View {
    @StateObject var vm: SettingsScreenVM
    
    var body: some View {
        ZStackWithBackground {
            content
        }
        .topBackBar()
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
    SettingsScreen(vm: SettingsScreenVM(Services.shared))
}
