//
//  MainViewModel.swift
//  Aktuel
//  Created by Turan Çabuk on 29.11.2022.

import Foundation


final class MainViewModel {
    
    var productList = [Product]()
    var categoryList: [String] = []
    var categorryArray: [String] = []
    var uniqueArray: [String] = []
    var categories: [String] = []

    var productListCount: Int {
        productList.count
    }
//    var categoriesListCount: Int {
//        categorryArray.count
//    }
    private let webservice: WebserviceProtocol = WebService()
    func getProducts(completion: @escaping () -> Void) {
        webservice.fetch(request: BaseRequest(), response: Aktuel.self, with: .getAktuel, completion: { result in
            switch result {
            case .success(let response):
                if let products = response.payload?.products {
                    self.productList = products
                    self.categories = Array(Set(products.map {$0.category_breadcrumb}))
                    for category in self.categoryList {
                      let string = category.components(separatedBy: "/")[0]
                        self.categorryArray.append(string)
                        let categorySet = Set(self.categorryArray)
                        let uniqueCategories = Array(categorySet)
                        self.uniqueArray.append(contentsOf: uniqueCategories)
                        self.categorryArray = Array(categorySet)
                    }
                }
                completion()
            case .failure(let error):
                print(error)
            }
        })
    }
}
