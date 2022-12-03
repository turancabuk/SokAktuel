//
//  ProductListCellViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 29.11.2022.
//

import UIKit
import Kingfisher

class ProductListCellViewController: UITableViewCell {


    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!
    
    
    func configCells(model: Product){
       
        self.productTitleLabel.text = model.title
        self.productPriceLabel.text = "\(model.price.original ?? 0)₺"
        self.productCategoryLabel.text = model.category_breadcrumb
        let baseUrl = "https://cdnd-tr.ceptesok.com//product//100x100//"
        let url = URL(string: "\(baseUrl)\(model.images?.first?.url ?? "")")
        self.productImageView.kf.setImage(with: url)
        self.productImageView.backgroundColor = UIColor.clear
       
        
    }
    
}
