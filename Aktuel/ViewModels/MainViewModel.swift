//
//  MainViewModel.swift
//  Aktuel
//  Created by Turan Çabuk on 29.11.2022.

import Foundation

final class MainViewModel {
 
    var productList = [Product]()
    var categories: [String] = []
    
    private let webservice: WebserviceProtocol = WebService()
   
    func getProducts(completion: @escaping (Result<Aktuel, Error>) -> Void) {
        
        let userRequest = UserRequest()
        
        webservice.fetch(request: userRequest, response: Aktuel.self, with: .getAktuel, completion: { result in
            switch result {
            case .success(let response):
                if let products = response.payload?.products {
                    self.productList = products
                    self.categories = Array(Set(products.map {$0.category_breadcrumb}))
                }
                completion(result)
            case .failure(let error):
                print(error)
            }
        })
    }
}
