//
//  HomeRouter.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import UIKit
import Foundation

class HomeRouter: HomeRouterProtocol {
    weak var view: UIViewController?
    
    static func createModule() -> HomeViewController {
        let router = HomeRouter()
        
        // MARK: Assign VVM - R
        let view = HomeViewController.instantiate()
        let viewModel: HomeViewModelProtocol = HomeViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.router = router
        router.view = view
        
        return view
    }
    
    func goToProductDetail(product: Product?) {
        view?.navigationController?.pushViewController(ProductDetailRouter.createModule(product: product), animated: true)
    }
}
