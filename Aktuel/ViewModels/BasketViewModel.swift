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
    var idArray = [UUID]()
    
    func getProductsFromBasket() {
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        let context = appDelegate.persistentContainer.viewContext
        let fetchRequest = NSFetchRequest<NSFetchRequestResult>(entityName: "AddBasket")
        fetchRequest.returnsObjectsAsFaults = false
        
        do {
            let results =  try? context.fetch(fetchRequest)
            for result in results as! [NSManagedObject] {
                if let id = result.value(forKey: "productID") as? UUID {
                    self.idArray.append(id)
                }
            }
        } catch {
            print("error")
        }
    }

}
