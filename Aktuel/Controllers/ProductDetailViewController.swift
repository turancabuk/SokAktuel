//
//  ProductDetailViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 5.12.2022.
//

import UIKit
import Kingfisher

class ProductDetailViewController: UIViewController {
    
    var selectedProduct: Product!
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var madeInLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        titleLabel.text = selectedProduct?.title
        productName.text = selectedProduct?.category_breadcrumb
        brandLabel.text = selectedProduct?.brand
        madeInLabel.text = selectedProduct?.madein
        priceLabel.text = "\(selectedProduct?.price.original ?? 0)TL"
        let baseUrl = "https://cdnd-tr.ceptesok.com//product//1000x1000//"
        let url = URL(string: "\(baseUrl)\(selectedProduct.images?.first?.url ?? "")")
        self.imageView.kf.setImage(with: url)


    }
}
