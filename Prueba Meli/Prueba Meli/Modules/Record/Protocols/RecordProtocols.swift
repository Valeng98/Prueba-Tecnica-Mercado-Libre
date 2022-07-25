//
//  RecordProtocols.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 19/07/22.
//

import Foundation
import UIKit

//MARK: Roter Protocol
protocol RecordRouterProtocol {
    var view: UIViewController? { get set }
    
    static func createModule() -> RecordViewController
}

//MARK: View Protocol
protocol RecordViewProtocol {
    var viewModel: RecordViewModelProtocol? { get set }
    
    
}

//MARK: ViewModel Protocol
protocol RecordViewModelProtocol {
    var view: RecordViewProtocol? { get set }
    var router: RecordRouterProtocol? { get set }
    
}
