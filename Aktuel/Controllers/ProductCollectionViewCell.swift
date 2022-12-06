//
//  ProductCollectionViewCell.swift
//  Aktuel
//
//  Created by Turan Çabuk on 5.12.2022.
//

import UIKit

class ProductCollectionViewCell: UICollectionViewCell {

    
    static let identifier = String(describing: ProductCollectionViewCell.self)
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.font = UIFont.systemFont(ofSize: 12, weight: UIFont.Weight.thin)

    }

    func configCollectionView(with model: Product ) {
        
        let baseUrl = "https://cdnd-tr.ceptesok.com//product//100x100//"
        if let url = URL(string: "\(baseUrl)\(model.images?.first?.url ?? "")") {
            imageView.kf.setImage(with: url)
        }
        categoryLabel.text = model.title
    }

}
