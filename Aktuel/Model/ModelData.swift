//
//  ModelData.swift
//  Aktuel
//
//  Created by Turan Çabuk on 30.11.2022.
import Foundation
import UIKit

struct collectionAktuel {
    let image: UIImage
    let category: String
    
    init(image: UIImage, category: String, model: Aktuel) {
        self.image = image
        self.category = category
    }
}
