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
                    /// Here I have created an array that takes the first parts of the elements of the categoryList array and add it to the categoryArray array.
                    for category in categoryList {
                        let string = category.components(separatedBy: "/")[0]
                        categoryArray.append(string)
                        
                        let categorySet = Set(categoryArray)
                        let uniqueCategories = Array(categorySet)
                        uniqeArray.append(contentsOf: uniqueCategories)
                        ///I deleted the repeating elements in the categoryArray array and added the regenerated array to the uniqeArray array.
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






