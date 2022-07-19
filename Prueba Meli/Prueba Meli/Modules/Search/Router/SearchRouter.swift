//
//  SearchRouter.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//

import Foundation
import UIKit

class SearchRouter: SearchRouterProtocol {
    weak var view: UIViewController?
    
    static func createModule(text: String) -> SearchViewController {
        let router = SearchRouter()
        
        // MARK: Assign VVM - R
        let view = SearchViewController.instantiate()
        let viewModel: SearchViewModelProtocol = SearchViewModel()
        
        view.viewModel = viewModel
        viewModel.view = view
        viewModel.router = router
        viewModel.textDefault = text
        router.view = view
        
        return view
    }
    
    func goToDetail(product: Product?) {
        view?.navigationController?.pushViewController(ProductDetailRouter.createModule(product: product), animated: true)
    }
}
