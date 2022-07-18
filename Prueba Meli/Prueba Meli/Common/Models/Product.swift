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
    let thumbnailID: String

    enum CodingKeys: String, CodingKey {
        case id, title, price, permalink
        case originalPrice = "original_price"
        case thumbnail
        case thumbnailID = "thumbnail_id"
    }
    
    var fullImage: String {
        return "https://http2.mlstatic.com/D_NQ_NP_\(self.thumbnailID)-Y.jpg"
    }
}
