//
//  UINavigationController+Extension.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 16/07/22.
//

import Foundation
import UIKit

extension UINavigationController {
    func themeNavigationBar() {
        let appearance = UINavigationBarAppearance()
        appearance.backgroundColor = UIColor(red: 253.0/255.0, green: 230.0/255.0, blue: 51.0/255.0, alpha: 1.0)
        appearance.shadowColor = .clear
        appearance.shadowImage = UIImage()
        
        let imageBack = UIImage(systemName: "arrow.backward")
        appearance.setBackIndicatorImage(imageBack, transitionMaskImage: imageBack)

        navigationBar.tintColor = .black
        navigationBar.standardAppearance = appearance
        navigationBar.compactAppearance = appearance
        navigationBar.scrollEdgeAppearance = appearance
    }
}
