//
//  HomeProtocols.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import Foundation
import UIKit

// MARK: - Router Protocol
protocol HomeRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    
    static func createModule() -> HomeViewController
}

// MARK: - View Protocol
protocol HomeViewProtocol: AnyObject {
    var viewModel: HomeViewModelProtocol? { get set }
    
    func update()
    func update(with error: String)
}

// MARK: - ViewModel Protocol
protocol HomeViewModelProtocol: AnyObject {
    var view: HomeViewProtocol? { get set }
    var router: HomeRouterProtocol? { get set }
    
    func getClothesAndAccessories()
    func listProductsCount() -> Int?
    func getProduct(index: Int) -> Product?
}


