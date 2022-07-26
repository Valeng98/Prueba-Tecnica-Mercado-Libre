//
//  Array+extension.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 26/07/22.
//

import Foundation

extension Sequence where Element: Hashable {
    func uniqued() -> [Element] {
        var set = Set<Element>()
        return filter { set.insert($0).inserted }
    }
}
