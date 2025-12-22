//
//  SettingsService.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation

final class SettingsService {
    private let soundSaver = DefaultsDataSaver<Bool>(key: "settings.sound")
    private let notificationSaver = DefaultsDataSaver<Bool>(key: "settings.notification")
    private let vibroSaver = DefaultsDataSaver<Bool>(key: "settings.vibration")
    
    func getSoundEnabled() -> Bool? {
        soundSaver.getValue()
    }
    
    func setSoundEnabled(_ value: Bool) {
        soundSaver.save(value)
    }
    
    func getNotificationEnabled() -> Bool? {
        notificationSaver.getValue()
    }
    
    func setNotificationEnabled(_ value: Bool) {
        notificationSaver.save(value)
    }
    
    func getVibroEnabled() -> Bool? {
        vibroSaver.getValue()
    }
    
    func setVibroEnabled(_ value: Bool) {
        vibroSaver.save(value)
    }
}
