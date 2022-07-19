//
//  HomeViewModel.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import Foundation

class HomeViewModel: HomeViewModelProtocol {
    weak var view: HomeViewProtocol?
    var router: HomeRouterProtocol?
    
    private var products: [Product]?
    
    func getClothesAndAccessories() {
        MeliNetworkManager.shared.getClothesAndAccessories { [weak self] result in
            switch result {
            case .success(let responce):
                self?.products = responce.results
                self?.view?.update()
            case .failure(let error):
                self?.view?.update(with: error.localizedDescription)
            }
        }
    }
    
    func listProductsCount() -> Int? {
        return products?.count 
    }
    
    func getProduct(index: Int) -> Product? {
        return products?[index]
    }
    
    func productDetail(index: Int) {
        let product = products?[index]
        router?.goToProductDetail(product: product)
    }
    
    func search(text: String) {
        router?.goToSearch(text: text)
    }
}
