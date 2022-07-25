//
//  SearchProtocols.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//

import Foundation
import UIKit

// MARK: - Router Protocol
protocol SearchRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    
    static func createModule(text: String) -> SearchViewController
    
    func goToDetail(product: Product?)

}

// MARK: - View Protocol
protocol SearchViewProtocol: AnyObject {
    var viewModel: SearchViewModelProtocol? { get set }
    
    func update()
    func update(with error: String)
    
}

// MARK: - ViewModel Protocol
protocol SearchViewModelProtocol: AnyObject {
    var view: SearchViewProtocol? { get set }
    var router: SearchRouterProtocol? { get set }
    var textDefault: String? { get set }
    
    func getTextDefault() -> String
    func resultProdcuts(text: String?)
    func resultProdcutsCount() -> Int?
    func getProduct(index: Int) -> Product?
    func detail(index: Int)
}
