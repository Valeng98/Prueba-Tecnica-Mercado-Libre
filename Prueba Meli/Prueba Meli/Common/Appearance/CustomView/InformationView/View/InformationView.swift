//
//  InformationView.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 27/07/22.
//

import UIKit

class InformationView: UIView {
    
    @IBOutlet var contentView: UIView!
    @IBOutlet private weak var infoImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    
    override init(frame: CGRect) {
        super.init(frame: frame)
        setupUI()
    }
    
    required init?(coder: NSCoder) {
        super.init(coder: coder)
        setupUI()
    }
    
    private func setupUI() {
        Bundle.main.loadNibNamed("InformationView", owner: self, options: nil)
        addSubview(contentView)
        contentView.frame = self.bounds
        contentView.autoresizingMask = [.flexibleHeight, .flexibleWidth]
    }
    
    func setup(model: InformationViewModel) {
        infoImage.image = UIImage(named: model.image)
        titleLabel.text = model.title
        descriptionLabel.text = model.description
    }
}
