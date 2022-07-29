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
    
    func alertView(model: InformationViewModel) {
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
    
    func alertModal(mensaje: String, completion: ((UIAlertAction) -> Void)? = nil){
        let alert = UIAlertController(title: "Alerta!", message: mensaje, preferredStyle: .alert)
        alert.addAction(UIAlertAction(title: "Cerrar", style: .cancel, handler: completion))
            
        present(alert, animated: true)
    }
}
