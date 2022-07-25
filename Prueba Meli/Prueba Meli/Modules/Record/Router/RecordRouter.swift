//
//  RecordRouter.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 19/07/22.
//

import Foundation
import UIKit

class RecordRouter: RecordRouterProtocol {
    var view: UIViewController?
    
    static func createModule() -> RecordViewController {
        let router = RecordRouter()
        
        // MARK: Assign VVM - R
        let view = RecordViewController.instantiate()
        var viewModel: RecordViewModelProtocol = RecordViewModel()
       
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.router = router
        router.view = view
        
        return view

    }
}
