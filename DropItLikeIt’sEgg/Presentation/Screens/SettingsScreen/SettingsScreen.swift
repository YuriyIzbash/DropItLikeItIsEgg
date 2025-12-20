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
        .customAlert(
            title: "Saved",
            message: "Your settings has been saved.",
            isPresented: $vm.showSaveConfirmation
        )
    }
    
    private var content: some View {
        VStack {
            header
                .padding(.horizontal, 32)
            
            settingsCard
            saveButton
                .padding(.horizontal, 32)
            
        }
        .frame(maxHeight: .infinity, alignment: .top)
        .onAppear {
            vm.load()
        }
    }
}

private extension SettingsScreen {
    var header: some View {
        HStack {
            NavBtn(type: .back) { dismiss() }
            
            Spacer()
        }
        .padding(.bottom, 104)
    }
    
    var settingsCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.appMain)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.appPink, lineWidth: 2)
            )
            .overlay(settingsContent, alignment: .top)
            .frame(width: 350, height: 300, alignment: .center)
    }
    
    var settingsContent: some View {
        VStack {
            Text("SETTINGS")
                .customFont(size: 24)
                .padding(.top, 16)
            
            SettingToggleRow(title: "SOUND", isOn: $vm.soundIsOn)
            SettingToggleRow(title: "NOTIFICATION", isOn: $vm.notificationIsOn)
            SettingToggleRow(title: "VIBRATION", isOn: $vm.vibroIsOn)
        }
    }
    
    var saveButton: some View {
        MainBtn(title: "SAVE") {
            vm.save()
        }
        .frame(height: 140)
        .padding(.horizontal, 48)
        .padding(.top, 80)
    }
}

private struct SettingToggleRow: View {
    let title: String
    @Binding var isOn: Bool
    
    var body: some View {
        HStack {
            Text(title)
                .customFont(size: 16)
                .layoutPriority(1)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
        }
        .padding(.horizontal, 56)
        .padding(.vertical, 16)
    }
}

#Preview {
    SettingsScreen(vm: SettingsScreenVM())
}
