//
//  RecordTableViewCell.swift
//  Prueba Meli
//
//  Created by Valentina Guarnizo on 19/07/22.
//

import UIKit

class RecordTableViewCell: UITableViewCell {

    @IBOutlet weak var recordTitleLabel: UILabel!
    
    static let identifier = "RecordTableViewCell"

    override func awakeFromNib() {
        super.awakeFromNib()
    }
    
    func setUp(text: String?) {
        recordTitleLabel.text = text
    }
}
