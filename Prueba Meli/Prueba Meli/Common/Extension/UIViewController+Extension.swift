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
    
    func alert(model: InformationViewModel) {
        let viewInformation = InformationView(frame: view.frame)
        view.addSubview(viewInformation)
        
        viewInformation.translatesAutoresizingMaskIntoConstraints = false
        NSLayoutConstraint.activate([
            viewInformation.leadingAnchor.constraint(equalTo: view.leadingAnchor),
            viewInformation.trailingAnchor.constraint(equalTo: view.trailingAnchor),
            viewInformation.topAnchor.constraint(equalTo: view.topAnchor),
            viewInformation.bottomAnchor.constraint(equalTo: view.bottomAnchor)
        ])
        
        viewInformation.setup(model: model)
    }
}
