//
//  SettingsScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import Combine

final class SettingsScreenVM: BaseModel {
    @Published var soundIsOn: Bool = false
    @Published var notificationIsOn: Bool = false
    @Published var vibroIsOn: Bool = false
    @Published var showSaveConfirmation: Bool = false
    
    override init(_ services: Services) {
        super.init(services)
        load()
    }
    
    func load() {
        if let v = settingsService.getSoundEnabled() { soundIsOn = v }
        if let v = settingsService.getNotificationEnabled() { notificationIsOn = v }
        if let v = settingsService.getVibroEnabled() { vibroIsOn = v }
    }
    
    func save() {
        settingsService.setSoundEnabled(soundIsOn)
        settingsService.setNotificationEnabled(notificationIsOn)
        settingsService.setVibroEnabled(vibroIsOn)
        showSaveConfirmation = true
    }
}
