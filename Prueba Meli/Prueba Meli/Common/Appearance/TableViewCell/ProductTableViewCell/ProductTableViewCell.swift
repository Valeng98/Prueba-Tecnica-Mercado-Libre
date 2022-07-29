//
//  ProductTableViewCell.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 14/07/22.
//

import UIKit
import SkeletonView

class ProductTableViewCell: UITableViewCell {
    
    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    static let identifier = "ProductTableViewCell"
    
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
        guard let product = product else {
            contentView.showAnimatedSkeleton()
            return
        }
        contentView.hideSkeleton()
        titleLabel.text = product.title
        priceLabel.text = product.price.moneyFormat()
        productImage.downloadUrl(url: product.thumbnail)
    }
}


