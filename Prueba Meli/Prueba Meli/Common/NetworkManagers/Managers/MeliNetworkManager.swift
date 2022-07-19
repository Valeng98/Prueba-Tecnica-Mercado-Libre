//
//  MeliNetworkManager.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 15/07/22.
//

import Foundation

class MeliNetworkManager {
    static var shared: MeliNetworkManager = {
        let instance = MeliNetworkManager()
        return instance
    }()
    
    func getClothesAndAccessories(completion: @escaping (Result<ResponseMeli, Error>) -> Void) {
        Services.shared.request(endPoint: .clothesAndAccessories, expecting: ResponseMeli.self, completion: completion)
    }
    
    func getSearch(query: String, completion: @escaping (Result<ResponseMeli, Error>) -> Void) {
        Services.shared.request(endPoint: .search(query: query), expecting: ResponseMeli.self, completion: completion)
    }
}
