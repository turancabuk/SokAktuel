//
//  MainViewModel.swift
//  Aktuel
//  Created by Turan Çabuk on 29.11.2022.

import Foundation


final class MainViewModel {
    
    var categories: [String] = []
    var productList = [Product]()
    var productListCount: Int {
        productList.count
    }
    var categoriesListCount: Int {
        categories.count
    }
    
    private let webservice: WebserviceProtocol = WebService()
    func getProducts(completion: @escaping () -> Void) {
        webservice.fetch(request: BaseRequest(), response: Aktuel.self, with: .getAktuel, completion: { result in
            switch result {
            case .success(let response):
                if let products = response.payload?.products {
                    self.productList = products
                    self.categories = Array(Set(products.map {$0.category_breadcrumb}))
                }
                completion()
            case .failure(let error):
                print(error)
            }
        })
    }
}
