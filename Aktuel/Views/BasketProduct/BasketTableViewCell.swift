//
//  BasketTableViewCell.swift
//  Aktuel
//
//  Created by Turan Çabuk on 15.12.2022.
//

import UIKit
import CoreData

class BasketTableViewCell: UITableViewCell {
    
    var viewModel: BasketViewModel!
    @IBOutlet weak var basketTitleLabel: UILabel!
    @IBOutlet weak var basketImageView: UIImageView!
    @IBOutlet weak var basketCategoryLabel: UILabel!
    @IBOutlet weak var basketPriceLabel: UILabel!
    
    
    
    
    
    func configCell(model: NSManagedObject){
        if let imageData = model.value(forKey: "productImage") {
            self.basketImageView.image = UIImage(data: imageData as! Data)
        }
        self.basketTitleLabel?.text = model.value(forKey: "productTitle") as? String
        self.basketPriceLabel.text = "\(model.value(forKey: "productPrice") ?? "0") TL"
        self.basketCategoryLabel.text = model.value(forKey: "productCategory") as? String
    }
}
