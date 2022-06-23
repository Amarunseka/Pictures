//
//  SortingBehavior.swift
//  Pictures
//
//  Created by Миша on 22.06.2022.
//

import Foundation

class SortingBehavior {
    
    static let shared = SortingBehavior()
    
    var sortingModel: SortingModel {
        if let sorting = UserDefaultsManager.obtainSortingData() {
            return sorting
        } else {
            return SortingModel(isSorting: true, sortingMode: 0)
        }
    }
    private init(){}
}
