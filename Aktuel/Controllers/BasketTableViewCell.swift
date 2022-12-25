//
//  BasketTableViewCell.swift
//  Aktuel
//
//  Created by Turan Çabuk on 15.12.2022.
//

import UIKit

class BasketTableViewCell: UITableViewCell {

    @IBOutlet weak var basketTitleLabel: UILabel!
    @IBOutlet weak var basketImageView: UIImageView!
    @IBOutlet weak var basketCategoryLabel: UILabel!
    @IBOutlet weak var basketPriceLabel: UILabel!
    @IBOutlet weak var removeToBasketButtonClicked: UIButton!
    
    func configCells(model: BasketViewModel){
       
        let item = model.productList[0]
        self.basketTitleLabel.text = item.value(forKey: "productTitle") as! String
    }
}
