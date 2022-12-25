//
//  BasketViewModel.swift
//  Aktuel
//
//  Created by Turan Çabuk on 16.12.2022.
//

import Foundation
import UIKit
import CoreData

final class BasketViewModel {
   
    var titleArray = [String]()
    var categorryArray = [String]()
    var priceArray = [Int]()
    var imageArray = [Data]()
    var productList: [NSManagedObject] = []

    
    func getBasket() {
        
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddBasket")
        
        do {
            let results = try context.fetch(fetchRequest) as! [NSManagedObject]
                self.productList = results
        } catch {
            print ("Error\(error.localizedDescription)")
        }
        for products in productList {
            
            let title = products.value(forKey: "productTitle") as? String
            let category = products.value(forKey: "productCategory") as? String
            let price = products.value(forKey: "productPrice") as? Int
            let image = products.value(forKey: "productImage") as? Data
        }
    }
    
}
struct CartObject: Codable {
    let image: Data?
    let title: String
    let price: Int
    let categorry: String
}
