//
//  ProductDetailRouter.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 16/07/22.
//

import Foundation
import UIKit


class ProductDetailRouter: ProductDetailRouterProtocol {
    weak var view: UIViewController?
    
    static func createModule(product: Product?) -> ProductDetailViewController {
        let router = ProductDetailRouter()
        
        // MARK: Assign VVM - R
        let view = ProductDetailViewController.instantiate()
        let viewModel: ProductDetailViewModelProtocol = ProductDetailViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.router = router
        viewModel.product = product
        router.view = view
        
        return view
    }
    
    func openUrl(url: URL) {
        UIApplication.shared.open(url)
    }
}

