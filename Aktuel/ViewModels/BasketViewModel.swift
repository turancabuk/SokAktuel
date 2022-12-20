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
    var imageArray = [URL]()
    
    
    func getBasket() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddBasket")
        
        do {
            let results = try context.fetch(fetchRequest)
            if results.count > 0 {
                for result in results as! [NSManagedObject] {
                    if let productTitle = result.value(forKey: "productTitle") as? String {
                        self.titleArray.append(productTitle)
                    }
                    if let productCategory = result.value(forKey: "productCategory") as? String {
                        self.categorryArray.append(productCategory)
                    }
                    if let productPrice = result.value(forKey: "productPrice") as? Int {
                        self.priceArray.append(productPrice)
                    }
                      if let productImage = result.value(forKey: "productImage") as? URL {
                          self.imageArray.append(productImage)
                    }
                }
            }
        } catch {
            
        }
        
    }
    
}

//func getProductsFromBasket() {
//    let appDelegate = UIApplication.shared.delegate as! AppDelegate
//    let context = appDelegate.persistentContainer.viewContext
//    let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddBasket")
//    fetchRequest.returnsObjectsAsFaults = false
//
//    do {
//        let results =  try? context.fetch(fetchRequest)
//        for result in results as! [NSManagedObject] {
//            if let id = result.value(forKey: "productID") as? UUID {
//                self.idArray.append(id)
//            }
//        }
//    } catch {
//        print("error")
//    }
//}
