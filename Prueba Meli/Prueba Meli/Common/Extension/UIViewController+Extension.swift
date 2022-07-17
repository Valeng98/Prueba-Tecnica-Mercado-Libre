//
//  UIViewController+Extension.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import Foundation
import UIKit

extension UIViewController {
    class func instantiate<T: UIViewController>(from storyboard: UIStoryboard, identifier: String) -> T {
        return storyboard.instantiateViewController(withIdentifier: identifier) as! T
    }
    
    class func instantiate() -> Self {
        let className = String(describing: self)
        return instantiate(from: UIStoryboard(name: className, bundle: Bundle(for: self)), identifier: className)
    }
}
