//
//  ProductDetailViewModel.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 16/07/22.
//

import Foundation

class ProductDetailViewModel: ProductDetailViewModelProtocol {
    weak var view: ProductDetailViewProtocol?
    var router: ProductDetailRouterProtocol?
    var product: Product?
    
    func getProduct() -> Product? {
        return product
    }
    
    func openUrl() {
        if let url = URL(string: product?.permalink ?? "") {
            router?.openUrl(url: url)
        }
    }
}
