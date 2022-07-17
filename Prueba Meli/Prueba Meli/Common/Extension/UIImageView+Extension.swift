//
//  UIImageView+Extension.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 16/07/22.
//

import Foundation
import UIKit

extension UIImageView {
    func downloadUrl(url: String) {
        guard let url = URL(string: url) else { return }
        
        let dataTask = URLSession.shared.dataTask(with: url) { [weak self] (data, _, _) in
            if let data = data {
                DispatchQueue.main.async {
                    self?.image = UIImage(data: data)
                }
            }
        }
        
        dataTask.resume()
    }
}
