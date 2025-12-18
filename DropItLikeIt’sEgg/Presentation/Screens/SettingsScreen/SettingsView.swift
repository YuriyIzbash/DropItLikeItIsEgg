//
//  SettingsView.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import SwiftUI

struct SettingsView: View {
    @State private var soundIsOn: Bool = false
    @State private var notificationIsOn: Bool = false
    @State private var vibroIsOn: Bool = false
    
    private let soundSaver = DefaultsDataSaver<Bool>(key: "settings.sound")
    private let notificationSaver = DefaultsDataSaver<Bool>(key: "settings.notification")
    private let vibroSaver = DefaultsDataSaver<Bool>(key: "settings.vibration")
    
    var body: some View {
        ZStack {
            MainBackground()
            content
        }
    }
    
    private var content: some View {
        VStack(alignment: .leading) {
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

private extension SettingsView {
    var header: some View {
        SquareBtn(type: .back) {
            print("Back tapped")
        }
        .padding(.bottom, 32)
    }
    
    var settingsCard: some View {
        RoundedRectangle(cornerRadius: 8, style: .continuous)
            .fill(Color.mainOpaque)
            .overlay(
                RoundedRectangle(cornerRadius: 8, style: .continuous)
                    .stroke(Color.strokeMain, lineWidth: 2)
            )
            .overlay(settingsContent, alignment: .top)
            .padding(.horizontal, 32)
    }
    
    var settingsContent: some View {
        VStack {
            Text("SETTINGS")
                .font(.subtitle)
                .appTextStyle()
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
    }
}

private struct SettingToggleRow: View {
    let title: String
    @Binding var isOn: Bool

    var body: some View {
        HStack {
            Text(title)
                .font(.placeholderText)
                .appTextStyle()
                .layoutPriority(1)
            Spacer()
            Toggle("", isOn: $isOn)
                .labelsHidden()
                .toggleStyle(SwitchToggleStyle())
        }
        .padding(.horizontal, 32)
        .padding(.vertical, 16)
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
    SettingsView()
}
