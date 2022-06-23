//
//  UserDefaultsManager.swift
//  Pictures
//
//  Created by Миша on 22.06.2022.
//

import Foundation

class UserDefaultsManager {
    
    static func saveSortingData(data value: SortingModel) {
        if let data = try? PropertyListEncoder().encode(value) {
            UserDefaults.standard.set(data, forKey: "sorting")
        }
    }
    
    static func obtainSortingData() -> SortingModel? {
        if let data = UserDefaults.standard.value(forKey: "sorting") as? Data {
            return try? PropertyListDecoder().decode(SortingModel.self, from: data)
        } else {
            return nil}
    }
}
