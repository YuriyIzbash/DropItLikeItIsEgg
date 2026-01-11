//
//  DefaultsDataSaver.swift
//  DropItLikeIt’sEgg
//
//  Created by yuriy on 18. 12. 25.
//

import Foundation
import os

class DefaultsDataSaver<T: Codable> {
    let key: String
    
    init(key: String) {
        self.key = key
    }
    
    func getValue() -> T? {
        loadAsData(for: key)
    }
    
    func save(_ item: T?) {
        saveAsData(item, for: key)
    }
    
    private func saveAsData(_ value: T?, for key: String) {
        let defaults = UserDefaults.standard
        let data = try? JSONEncoder().encode(value)
        defaults.set(data, forKey: key)
        defaults.synchronize()
    }
    
    private func loadAsData(for key: String) -> T? {
        let defaults = UserDefaults.standard
        guard let data = defaults.object(forKey: key) as? Data else {
            return nil
        }
        do {
            let value = try JSONDecoder().decode(T.self, from: data)
            return value
        } catch {
            logger.log("@@ERROR: \(error) decode \(T.self) from data: \(data)")
            return nil
        }
    }
}

extension DefaultsDataSaver: Loggerable {}
