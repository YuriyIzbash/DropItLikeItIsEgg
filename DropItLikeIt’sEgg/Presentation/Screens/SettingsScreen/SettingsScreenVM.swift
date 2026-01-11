//
//  SettingsScreenVM.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 20. 12. 25.
//

import Combine

@MainActor
final class SettingsScreenVM: BaseModel {
    @Published var showSaveConfirmation: Bool = false
    
    var soundIsOn: Bool {
        get { settingsService.isSoundEnabled }
        set { settingsService.isSoundEnabled = newValue }
    }
    
    var notificationIsOn: Bool {
        get { settingsService.isNotificationEnabled }
        set { settingsService.isNotificationEnabled = newValue }
    }
    
    var vibroIsOn: Bool {
        get { settingsService.isVibroEnabled }
        set { settingsService.isVibroEnabled = newValue }
    }
    
    override init(_ services: Services) {
        super.init(services)
    }
    
    func save() {
        showSaveConfirmation = true
    }
}
