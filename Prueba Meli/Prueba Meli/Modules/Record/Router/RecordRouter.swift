//
//  RecordRouter.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//
import Foundation
import UIKit

class RecordRouter: RecordRouterProtocol {
    weak var view: UIViewController?
    
    static func createModule() -> RecordViewController {
        let router = RecordRouter()
        
        // MARK: Assign VVM - R
        let view = RecordViewController.instantiate()
        let viewModel: RecordViewModelProtocol = RecordViewModel()
        

        router.view = view
        
        return view
        
    }
}
