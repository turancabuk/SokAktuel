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
    
    
    var paperproducts: [String] = []
    var PersonalCareCosmeticsProducts: [String] = []
    var breakfastProducts: [String] = []
    var frozenproducts: [String] = []
    var homeLifeProducts: [String] = []
    var foodMaterialProducts: [String] = []
    var snackProducts: [String] = []
    var motherBabyChildProducts: [String] = []
    var ClothingShoesAccessoryProducts: [String] = []
    var cleaningProducts: [String] = []
    var milkProducts: [String] = []
    var beverageProducts: [String] = []
    var electronicProducts: [String] = []
    
//    var productSections: [Int: [String]] = [:]
//    productSections[0] = paperproducts
//    productSections[1] = PersonalCareCosmeticsProducts
//    productSections[2] = breakfastProducts
//    productSections[3] = frozenproducts
//    productSections[4] = homeLifeProducts
//    productSections[5] = foodMaterialProducts
//    productSections[6] = snackProducts
//    productSections[7] = motherBabyChildProducts
//    productSections[8] = ClothingShoesAccessoryProducts
//    productSections[9] = cleaningProducts
//    productSections[10] = milkProducts
//    productSections[11] = beverageProducts
//    productSections[12] = electronicProducts

    

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
                                foodMaterialProducts.append(product.productName!)
                            case "Anne - Bebek & Çocuk":
                                motherBabyChildProducts.append(product.productName!)
                            case "Kahvaltılık":
                                breakfastProducts.append(product.productName!)
                            case "Giyim & Ayakkabı & Aksesuar":
                                ClothingShoesAccessoryProducts.append(product.productName!)
                            case "Kişisel Bakım & Kozmetik":
                                PersonalCareCosmeticsProducts.append(product.productName!)
                            case "Ev & Yaşam":
                                homeLifeProducts.append(product.productName!)
                            case "Temizlik":
                                cleaningProducts.append(product.productName!)
                            case "Süt & Süt Ürünleri":
                                milkProducts.append(product.productName!)
                            case "Dondurulmuş Ürünler":
                                frozenproducts.append(product.productName!)
                            case "Kağıt Ürünleri":
                                paperproducts.append(product.productName!)
                            case "Elektronik":
                                electronicProducts.append(product.productName!)
                            case "İçecek":
                                beverageProducts.append(product.productName!)
                            case "Atıştırmalık":
                                snackProducts.append(product.productName!)
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






