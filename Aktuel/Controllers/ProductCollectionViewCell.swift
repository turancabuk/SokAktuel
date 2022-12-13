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
        categoryLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)

    }

    func configCollectionView(with model: String) {
        categoryLabel.text = model
        
    
        
        
    }

}
