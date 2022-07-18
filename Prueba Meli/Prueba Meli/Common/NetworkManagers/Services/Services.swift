//
//  Services.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 15/07/22.
//

import Foundation
import UIKit

class Services {
    static var shared: Services = {
        let instance = Services()
        return instance
        
    }()
    
    func request<T: Codable>(endPoint: EndPointType, expecting: T.Type, completion: @escaping(Result<T, Error>) -> Void) {
        let session = URLSession.shared
        
        guard let url = endPoint.url else {
            completion(.failure(ErrorType.internal(reason: "Invalide URL")))
            return
        }
        
        let task = session.dataTask(with: url) { data, _, error in
            if let error = error {
                completion(.failure(ErrorType.internal(reason: error.localizedDescription)))
            }
            
            guard let data = data else {
                completion(.failure(ErrorType.generic(reason: "Invalid data")))
                return
            }
            
            do {
                let result = try JSONDecoder().decode(expecting, from: data)
                completion(.success(result))
            } catch {
                completion(.failure(ErrorType.internal(reason: error.localizedDescription)))
            }
        }
        
        task.resume()
        
    }
}
