//
//  Product.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 15/07/22.
//

import Foundation

struct Product: Codable {
    let id: String
    let title: String
    let price: Double
    let permalink: String
    let originalPrice: Int?
    let thumbnail: String
    

    enum CodingKeys: String, CodingKey {
        case id, title, price, permalink
        case originalPrice = "original_price"
        case thumbnail
    }
}
