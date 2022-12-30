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
    }
    
    
}
struct CartObject: Codable {
    let image: Data?
    let title: String
    let price: Int
    let categorry: String
}
