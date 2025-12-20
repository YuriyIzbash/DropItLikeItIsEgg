//
//  SettingsScreen.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

struct SettingsScreen: View {
    @Environment(\.dismiss) private var dismiss
    @State private var soundIsOn: Bool = false
    @State private var notificationIsOn: Bool = false
    @State private var vibroIsOn: Bool = false
    
    private let soundSaver = DefaultsDataSaver<Bool>(key: "settings.sound")
    private let notificationSaver = DefaultsDataSaver<Bool>(key: "settings.notification")
    private let vibroSaver = DefaultsDataSaver<Bool>(key: "settings.vibration")
    
    var body: some View {
        ZStackWithBackground {
            content
        }
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
            if let v = soundSaver.getValue() { soundIsOn = v }
            if let v = notificationSaver.getValue() { notificationIsOn = v }
            if let v = vibroSaver.getValue() { vibroIsOn = v }
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
            
            SettingToggleRow(title: "SOUND", isOn: $soundIsOn)
            SettingToggleRow(title: "NOTIFICATION", isOn: $notificationIsOn)
            SettingToggleRow(title: "VIBRATION", isOn: $vibroIsOn)
        }
    }
    
    var saveButton: some View {
        MainBtn(title: "SAVE") {
            soundSaver.save(soundIsOn)
            notificationSaver.save(notificationIsOn)
            vibroSaver.save(vibroIsOn)
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
    SettingsScreen()
}
