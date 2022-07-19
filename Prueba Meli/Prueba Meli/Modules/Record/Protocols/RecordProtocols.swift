//
//  RecordProtocols.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 18/07/22.
//

import Foundation
import UIKit

// MARK: - Router Protocol
protocol RecordRouterProtocol: AnyObject {
    var view: UIViewController? { get set }
    
    static func createModule() -> RecordViewController
}


// MARK: - View Protocol
protocol RecordViewProtocol: AnyObject {
    var viewModel: RecordViewModelProtocol? { get set }
}

// MARK: - ViewModel Protocol
protocol RecordViewModelProtocol: AnyObject {
    
}
