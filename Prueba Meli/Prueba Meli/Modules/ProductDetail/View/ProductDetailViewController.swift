//
//  ProductDetailViewController.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 16/07/22.
//

import UIKit

class ProductDetailViewController: UIViewController {

    @IBOutlet weak var productImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var buyButton: UIButton!
    
    var viewModel: ProductDetailViewModelProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        navigationController?.themeNavigationBar()
        view.backgroundColor = .white
        buyButton.layer.cornerRadius = 8
        buyButton.addTarget(self, action: #selector(actionBuy), for: .touchUpInside)
        setupProduct()
    }
    
    private func setupProduct() {
        guard let product = viewModel?.getProduct() else { return }
        
        titleLabel.text = product.title
        priceLabel.text = product.price.moneyFormat()
        productImage.downloadUrl(url: product.fullImage)
    }
     
    @objc private func actionBuy() {
        viewModel?.openUrl()
    }
}

extension ProductDetailViewController: ProductDetailViewProtocol {}
