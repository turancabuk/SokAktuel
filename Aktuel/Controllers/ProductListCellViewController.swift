//
//  ProductListCellViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 29.11.2022.
//

import UIKit
import Kingfisher
import CoreData

class ProductListCellViewController: UITableViewCell {


    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!


    func configCells(model: Product){

        self.productTitleLabel.text = model.title
        self.productPriceLabel.text = "\(model.price.original ?? 0)₺"
        self.productCategoryLabel.text = model.category_breadcrumb
        let baseUrl = "https://cdnd-tr.ceptesok.com//product//420x420//"
        let url = URL(string: "\(baseUrl)\(model.images?.first?.url ?? "")")
        self.productImageView.kf.setImage(with: url)
        self.productImageView.backgroundColor = UIColor.clear


    }
    
    @IBAction func addToBasketButtonClicked(_ sender: Any) {
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let saveData = NSEntityDescription.insertNewObject(forEntityName: "AddBasket", into: context)
        
        saveData.setValue(productTitleLabel.text, forKey: "productTitle")
        saveData.setValue(productCategoryLabel.text, forKey: "productCategory")
        saveData.setValue(productImageView.image, forKey: "productImage")
        if let price = Int(productPriceLabel.text!) {
            saveData.setValue(price, forKey: "productPrice")
            
            do {
                try context.save()
                print("succes!")
            } catch {
                print("error!")
            }
        }
        print("error!")
    }
}
