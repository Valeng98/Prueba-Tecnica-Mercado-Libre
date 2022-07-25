//
//  ProductDetailProtocols.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 16/07/22.
//

import Foundation
import UIKit

// MARK: - Router Protocol
protocol ProductDetailRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    
    static func createModule(product: Product?) -> ProductDetailViewController
    func openUrl(url: URL)
}

// MARK: - View Protocol
protocol ProductDetailViewProtocol: AnyObject {
    var viewModel: ProductDetailViewModelProtocol? { get set }
}

// MARK: - ViewModel Protocol
protocol ProductDetailViewModelProtocol: AnyObject {
    var view: ProductDetailViewProtocol? { get set }
    var router: ProductDetailRouterProtocol? { get set }
    var product: Product? { get set }
    
    func getProduct() -> Product?
    func openUrl()
}
