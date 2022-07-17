//
//  EndPointType.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 15/07/22.
//

import Foundation

enum EndPointType {
    case clothesAndAccessories
    case search(query: String)
    
    var url: URL? {
        var components = URLComponents()
        components.host = "api.mercadolibre.com"
        components.scheme = "https"
    
        switch self {
        case .clothesAndAccessories:
            components.path = "/sites/MLA/search"
            components.queryItems = [
            URLQueryItem(name: "category", value: "MLA1430")
            ]
        case .search(let query):
            components.path = "/sites/MLA/search"
            components.queryItems = [
                URLQueryItem(name: "q", value: query.addingPercentEncoding(withAllowedCharacters: .urlHostAllowed))
            ]
        }
        
        return components.url
    }
}


