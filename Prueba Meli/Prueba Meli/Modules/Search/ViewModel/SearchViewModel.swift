//
//  SearchViewModel.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//

import Foundation

class SearchViewModel: SearchViewModelProtocol {
    var view: SearchViewProtocol?
    var router: SearchRouterProtocol?
    var textDefault: String?
    
    private var products: [Product]?

    
    func getTextDefault() -> String {
        return textDefault ?? ""
    }
    
    func resultProdcuts() {
        MeliNetworkManager.shared.getSearch(query: textDefault ?? "") { [weak self] result in
            switch result {
            case .success(let response):
                self?.products = response.results
                self?.view?.update()
            case .failure(let error):
                self?.view?.update(with: error.localizedDescription)
            }
        }
        
    }
    
    func resultProdcutsCount() -> Int? {
        return products?.count
    }
    
    func getProduct(index: Int) -> Product? {
        return products?[index]
    }
    
    func detail(index: Int) {
        let product = products?[index]
        router?.goToDetail(product: product)
    }
}


