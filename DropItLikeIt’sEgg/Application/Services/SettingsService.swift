//
//  SettingsService.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 22. 12. 25.
//

import Combine

@MainActor
final class SettingsService: ObservableObject {
    @PublishedStored(wrappedValue: false, key: "settings.isSoundEnabled")
    var isSoundEnabled: Bool
    
    @PublishedStored(wrappedValue: false, key: "settings.isNotificationEnabled")
    var isNotificationEnabled: Bool
    
    @PublishedStored(wrappedValue: false, key: "settings.isViibrationEnabled")
    var isVibroEnabled: Bool
}
