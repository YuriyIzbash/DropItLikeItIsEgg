//
//  PublishedStored.swift
//  DropItLikeIt'sEgg
//
//  Created by yuriy on 11. 01. 26.
//

import Foundation
import Combine

/// A property wrapper that combines @Published behavior with UserDefaults persistence.
/// Automatically saves changes to UserDefaults and publishes updates to observers.
@propertyWrapper
@MainActor
final class PublishedStored<Value: Codable> {
    private let storage: DefaultsDataSaver<Value>
    private let subject: CurrentValueSubject<Value, Never>
    
    var wrappedValue: Value {
        get { subject.value }
        set { 
            subject.send(newValue)
            storage.save(newValue)
        }
    }
    
    var projectedValue: AnyPublisher<Value, Never> {
        subject.eraseToAnyPublisher()
    }
    
    init(wrappedValue defaultValue: Value, key: String) {
        self.storage = DefaultsDataSaver<Value>(key: key)
        let stored = storage.getValue() ?? defaultValue
        self.subject = CurrentValueSubject(stored)
    }
}
