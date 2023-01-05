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
        
    var paperproducts: [Product] = []
    var PersonalCareCosmeticsProducts: [Product] = []
    var breakfastProducts: [Product] = []
    var frozenproducts: [Product] = []
    var homeLifeProducts: [Product] = []
    var foodMaterialProducts: [Product] = []
    var snackProducts: [Product] = []
    var motherBabyChildProducts: [Product] = []
    var ClothingShoesAccessoryProducts: [Product] = []
    var cleaningProducts: [Product] = []
    var milkProducts: [Product] = []
    var beverageProducts: [Product] = []
    var electronicProducts: [Product] = []
    
    enum ProductCategory {
        case paperproducts
        case PersonalCareCosmeticsProducts
        case breakfastProducts
        case frozenproducts
        case homeLifeProducts
        case foodMaterialProducts
        case snackProducts
        case motherBabyChildProducts
        case ClothingShoesAccessoryProducts
        case cleaningProducts
        case milkProducts
        case beverageProducts
        case electronicProducts
    }



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
                        /// Here, I will assign the different categories returned from the response to the above related arrays to filter the collectionView.
                        for product in productList {

                            switch product.categoryBreadcrumb {
                            case "Yemeklik Malzemeler" :
                                foodMaterialProducts.append(product)
                            case "Anne - Bebek & Çocuk":
                                motherBabyChildProducts.append(product)
                            case "Kahvaltılık":
                                breakfastProducts.append(product)
                            case "Giyim & Ayakkabı & Aksesuar":
                                ClothingShoesAccessoryProducts.append(product)
                            case "Kişisel Bakım & Kozmetik":
                                PersonalCareCosmeticsProducts.append(product)
                            case "Ev & Yaşam":
                                homeLifeProducts.append(product)
                            case "Temizlik":
                                cleaningProducts.append(product)
                            case "Süt & Süt Ürünleri":
                                milkProducts.append(product)
                            case "Dondurulmuş Ürünler":
                                frozenproducts.append(product)
                            case "Kağıt Ürünleri":
                                paperproducts.append(product)
                            case "Elektronik":
                                electronicProducts.append(product)
                            case "İçecek":
                                beverageProducts.append(product)
                            case "Atıştırmalık":
                                snackProducts.append(product)
                            default: break
                            }
                        }
                    }
                    print("categoryArray:", categoryArray)
                }
                completion()
            case .failure(let error):
                print("bu hatanın sebebi: \(error)")
            }
        })
    }
}






