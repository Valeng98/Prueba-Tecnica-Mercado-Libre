//
//  RecordViewController.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//

import UIKit

class RecordViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = .yellow
        
        let someView = UIButton()
        someView.addTarget(self, action: #selector(click), for: .touchUpInside)
        someView.backgroundColor = .red
        someView.translatesAutoresizingMaskIntoConstraints = false
        
        view.addSubview(someView)
        
        NSLayoutConstraint.activate([
            someView.centerXAnchor.constraint(equalTo: view.centerXAnchor),
            someView.centerYAnchor.constraint(equalTo: view.centerYAnchor),
            someView.heightAnchor.constraint(equalToConstant: 50),
            someView.widthAnchor.constraint(equalToConstant: 50)
        ])
    }
    
    @objc func click() {
        dismiss(animated: true, completion: nil)
   
    }

}
