//
//  DropItLikeItIsEggApp.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 16. 12. 25.
//

import SwiftUI

@main
struct DropItLikeItIsEggApp: App {
    let services = Services.shared
    
    var body: some Scene {
        WindowGroup {
            ContentView(services: services)
        }
    }
}
