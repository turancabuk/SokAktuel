//
//  ProductListCellViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 29.11.2022.
//

import UIKit
import Kingfisher
import CoreData

protocol ProductListDelegate: AnyObject {
    func didSelectProduct()
}

class ProductListTableViewCell: UITableViewCell {

    @IBOutlet weak var productTitleLabel: UILabel!
    @IBOutlet weak var productCategoryLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageView: UIImageView!

    
    func configCells(model: Product){
        self.productTitleLabel.text = model.title
        self.productPriceLabel.text = "\(model.price?.original ?? 0)₺"
        self.productCategoryLabel.text = model.categoryBreadcrumb
        let baseUrl = "https://cdnd-tr.ceptesok.com//product//420x420//"
        let url = URL(string: "\(baseUrl)\(model.images?.first?.url ?? "")")
        self.productImageView.kf.setImage(with: url)
        self.productImageView.backgroundColor = UIColor.clear
    }
    
    @IBAction func addToBasketButtonClicked(_ sender: Any) {

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddBasket")
        fetchRequest.predicate = NSPredicate(format: "productTitle == %@", productTitleLabel.text!)

        do {
            let result = try context.fetch(fetchRequest)
            if result.count > 0 {
                print("Bu ürün zaten sepetinizde mevcut!")
            } else {
                let saveData = NSEntityDescription.insertNewObject(forEntityName: "AddBasket", into: context)
                saveData.setValue(productTitleLabel.text, forKey: "productTitle")
                saveData.setValue(productCategoryLabel.text, forKey: "productCategory")
                let data = productImageView.image!.jpegData(compressionQuality: 0.5)
                saveData.setValue(data, forKey: "productImage")
                let price = Int(productPriceLabel.text ?? "0")
                saveData.setValue(price, forKey: "productPrice")
                try context.save()
                print("success!")
            }

        } catch {
            print("error!")
        }
        
    }
}














