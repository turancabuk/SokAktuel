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
    
    var kagitUrunleri: [String] = []
    var kisiselBakimKozmetik: [String] = []
    var kahvaltilik: [String] = []
    var dondurulmusUrunler: [String] = []
    var evYasam: [String] = []
    var yemeklikMalzemeler: [String] = []
    var atistirmalik: [String] = []
    var anneBebekCocuk: [String] = []
    var giyimAyakkabiAksesuar: [String] = []
    var temizlik: [String] = []
    var sutSutUrunleri: [String] = []
    var icecek: [String] = []
    var elektronik: [String] = []
    

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
                        /// Burada collectionView'da filtreleme yapmak için response'dan dönen farklı kategorileri yukarıdaki ilgili arraylere atayacağım.
                        for product in productList {

                            switch product.categoryBreadcrumb {
                            case "Yemeklik Malzemeler" :
                                yemeklikMalzemeler.append(product.productName!)
                            case "Anne - Bebek & Çocuk":
                                anneBebekCocuk.append(product.productName!)
                            case "Kahvaltılık":
                                kahvaltilik.append(product.productName!)
                            case "Giyim & Ayakkabı & Aksesuar":
                                giyimAyakkabiAksesuar.append(product.productName!)
                            case "Kişisel Bakım & Kozmetik":
                                kisiselBakimKozmetik.append(product.productName!)
                            case "Ev & Yaşam":
                                evYasam.append(product.productName!)
                            case "Temizlik":
                                temizlik.append(product.productName!)
                            case "Süt & Süt Ürünleri":
                                sutSutUrunleri.append(product.productName!)
                            case "Dondurulmuş Ürünler":
                                dondurulmusUrunler.append(product.productName!)
                            case "Kağıt Ürünleri":
                                kagitUrunleri.append(product.productName!)
                            case "Elektronik":
                                elektronik.append(product.productName!)
                            case "İçecek":
                                icecek.append(product.productName!)
                            case "Atıştırmalık":
                                atistirmalik.append(product.productName!)
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






