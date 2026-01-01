//
//  EasyLog.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 31. 12. 25.
//


import Foundation
import os

struct EasyLog {
    static let subsystem = Bundle.main.bundleIdentifier ?? "App"
    typealias Category = String
    
    static func log(_ category: Category) -> Logger {
        Logger(subsystem: subsystem, category: category)
    }
}

protocol Loggerable {
    var logger: Logger { get }
}

extension Loggerable {
    var logger: Logger {
        EasyLog.log(String(describing: type(of: self)))
    }
}