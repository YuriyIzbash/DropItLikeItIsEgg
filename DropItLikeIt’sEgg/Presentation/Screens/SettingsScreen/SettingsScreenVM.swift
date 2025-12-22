//
//  SettingsScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import Combine

@MainActor
final class SettingsScreenVM: ObservableObject {
    @Published var soundIsOn: Bool = false
    @Published var notificationIsOn: Bool = false
    @Published var vibroIsOn: Bool = false
    @Published var showSaveConfirmation: Bool = false
    
    private let soundSaver = DefaultsDataSaver<Bool>(key: "settings.sound")
    private let notificationSaver = DefaultsDataSaver<Bool>(key: "settings.notification")
    private let vibroSaver = DefaultsDataSaver<Bool>(key: "settings.vibration")
    
    init() {
        load()
    }
    func load() {
        if let v = soundSaver.getValue() { soundIsOn = v }
        if let v = notificationSaver.getValue() { notificationIsOn = v }
        if let v = vibroSaver.getValue() { vibroIsOn = v }
    }
    
    func save() {
        soundSaver.save(soundIsOn)
        notificationSaver.save(notificationIsOn)
        vibroSaver.save(vibroIsOn)
        showSaveConfirmation = true
    }
}
