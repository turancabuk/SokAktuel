//
//  CollectionViewCell.swift
//  Aktuel
//
//  Created by Turan Çabuk on 4.12.2022.
//

import UIKit
import Kingfisher

class CollectionViewCell: UICollectionViewCell {
    
    static let identifier = String(describing: CollectionViewCell.self)

    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    func configCollectionView(with model: Product ) {
        
        let baseUrl = "https://cdnd-tr.ceptesok.com//product//100x100//"
        let url = URL(string: "\(baseUrl)\(model.images?.first?.url ?? "")")
        imageView.kf.setImage(with: url)
//        categoryLabel.text = model.category_breadcrumb
    }
}
