//
//  HelperRecord.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 26/07/22.
//

import Foundation

struct HelperRecord {
    static let keyforLaunch = "recordList"
    static let defaults = UserDefaults.standard
    static let maxValues = 15
    
    static var recordList: [String] {
        get {
            defaults.object(forKey: keyforLaunch) as? [String] ?? [String]()
        }
        set {
            var newList = newValue.uniqued()
            if newList.count > maxValues {
                newList.removeLast()
            }
            
            defaults.set(newList, forKey: keyforLaunch)
        }
    }
    
    static func removeRecord() {
        defaults.removeObject(forKey: keyforLaunch)
    }
}
