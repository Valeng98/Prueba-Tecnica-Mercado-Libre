//
//  ProductTableViewCell.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import UIKit

class ProductTableViewCell: UITableViewCell {

    static let identifier = "ProductTableViewCell"
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    override func layoutSubviews() {
        super.layoutSubviews()
        selectionStyle = .none
        contentView.backgroundColor = .clear
        productImage.layer.cornerRadius = 10
        
    }

    func configureCell(product: Product?) {
        guard let product = product else { return }
        
        titleLabel.text = product.title
        priceLabel.text = String(product.price)
        productImage.downloadUrl(url: product.thumbnail)
        
    }
}


