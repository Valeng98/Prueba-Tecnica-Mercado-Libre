//
//  Double+Extension.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 17/07/22.
//

import Foundation
import UIKit

extension Double {
    func moneyFormat() -> String {
        let formatter = NumberFormatter()
        formatter.locale = Locale.current
        formatter.numberStyle = .currency
        formatter.maximumFractionDigits = 0
        formatter.currencySymbol = "$"
        formatter.currencyGroupingSeparator = "."
        if let formatted = formatter.string(from: self as NSNumber) {
            return formatted
        } else {
            return String()
        }
    }
}
