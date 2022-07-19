//
//  RecordViewModel.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//

import Foundation

class RecordViewModel: RecordViewModelProtocol {
    
   // weak  var view: ProductDetailViewProtocol?
    var router: RecordRouterProtocol?
    var product: Product?
    
    func getProduct() -> Product? {
        return product
    }
    
}
