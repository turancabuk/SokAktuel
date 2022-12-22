//
//  MainViewModel.swift
//  Aktuel
//  Created by Turan Çabuk on 29.11.2022.

import Foundation

final class MainViewModel {
    var productList = [Product]()
    var categoryList: [String] = []
    var categoryArray: [String] = []
    var uniqeArray: [String] = []

    private let webService: WebserviceProtocol = WebService()

    func getProducts(completion: @escaping () -> Void) {
        webService.fetch(response: Aktuel.self, with: .getAktuel, completion: { [self] result in
            switch result {
            case .success(let response):
                if let products = response.payload?.products {
                    self.productList = products
                    self.categoryList = Array(Set(products.map{ $0.categoryBreadcrumb! }))
                    /// Burada categoryList dizisinin elemanlarının ilk bölümlerini alan bir dizi oluşturdum ve categoryArray dizisine ekledim.
                    for category in categoryList {
                        let string = category.components(separatedBy: "/")[0]
                        categoryArray.append(string)
                        
                        let categorySet = Set(categoryArray)
                        let uniqueCategories = Array(categorySet)
                        uniqeArray.append(contentsOf: uniqueCategories)
                        ///categoryArray dizisindeki tekrarlayan elemanlar sildim ve tekrar ürettiğim diziyi, uniqeArray dizisine ekledim.
                        categoryArray = Array(categorySet)
                    }
                }
                completion()
            case .failure(let error):
                print("bu hatanın sebebi: \(error.localizedDescription)")
            }
        })
    }
}





