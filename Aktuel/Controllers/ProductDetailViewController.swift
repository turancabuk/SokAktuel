//
//  ProductDetailViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 5.12.2022.
//

import UIKit
import Kingfisher

class ProductDetailViewModel {
    var selectedProduct: Product!
    
    init(selectedProduct: Product) {
        self.selectedProduct = selectedProduct
    }
}

class ProductDetailViewController: UIViewController {
    
    var viewModel: ProductDetailViewModel?
    
    @IBOutlet weak var productName: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var brandLabel: UILabel!
    @IBOutlet weak var madeInLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var madeAtLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        titleLabel.text = viewModel?.selectedProduct.title
        brandLabel.text = viewModel?.selectedProduct.brand
        productName.text = viewModel?.selectedProduct.categoryBreadcrumb
        brandLabel.text = viewModel?.selectedProduct.brand
        madeInLabel.text = viewModel?.selectedProduct.madein
        priceLabel.text = "\((viewModel?.selectedProduct.price?.originalStr)!)TL"
        madeAtLabel.text = viewModel?.selectedProduct.createdAt
        let baseUrl = "https://cdnd-tr.ceptesok.com//product//1000x1000//"
        if let url = URL(string: "\(baseUrl)\(viewModel?.selectedProduct.images?.first?.url ?? "")") {
            self.imageView.kf.setImage(with: url)
        }
    }
}
 
