//
//  SettingsService.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Foundation

@MainActor
final class SettingsService {
    private let isSoundEnabledStorage = DefaultsDataSaver<Bool>(key: "settings.isSoundEnabled")
    private let isNotificationEnabledStorage = DefaultsDataSaver<Bool>(key: "settings.isNotificationEnabled")
    private let isVibroEnabledStorage = DefaultsDataSaver<Bool>(key: "settings.isViibrationEnabled")
}

//MARK: - Sound Setting

extension SettingsService {
    func getSoundEnabled() -> Bool {
        isSoundEnabledStorage.getValue() ?? false
    }
    
    func setSoundEnabled(_ value: Bool) {
        isSoundEnabledStorage.save(value)
    }
}

//MARK: - Notification Setting

extension SettingsService {
    func getNotificationEnabled() -> Bool {
        isNotificationEnabledStorage.getValue() ?? false
    }
    
    func setNotificationEnabled(_ value: Bool) {
        isNotificationEnabledStorage.save(value)
    }
}

//MARK: - Vibro Setting

extension SettingsService {
    func getVibroEnabled() -> Bool {
        isVibroEnabledStorage.getValue() ?? false
    }
    
    func setVibroEnabled(_ value: Bool) {
        isVibroEnabledStorage.save(value)
    }
}
