//
//  ProductCollectionViewCell.swift
//  Aktuel
//
//  Created by Turan Çabuk on 5.12.2022.
//

import Kingfisher
import UIKit


class ProductCollectionViewCell: UICollectionViewCell {

    
    static let identifier = String(describing: ProductCollectionViewCell.self)
    
    @IBOutlet weak var imageView: UIImageView!
    @IBOutlet weak var categoryLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        categoryLabel.font = UIFont.systemFont(ofSize: 11, weight: UIFont.Weight.light)

    }

    func configCollectionView(with model: String) {
        categoryLabel.text = model
        
        switch model {
        case "Ekmek & Pastane":
            imageView.image = UIImage(named: "ekmekpastane")
        case "Temizlik":
            imageView.image = UIImage(named: "temizlikurunleri")
        case "Yemeklik Malzemeler":
            imageView.image = UIImage(named: "yemeklikmalzemeler")
        case "Süt & Süt Ürünleri":
            imageView.image = UIImage(named: "suturunleri")
        case "Kağıt Ürünleri":
            imageView.image = UIImage(named: "kagiturunleri")
        case "Kişisel Bakım & Kozmetik":
            imageView.image = UIImage(named: "kisiselbakim")
        case "Elektronik":
            imageView.image = UIImage(named: "elektronik")
        case "Kahvaltılık":
            imageView.image = UIImage(named: "kahvaltilik")
        case "Atıştırmalık":
            imageView.image = UIImage(named: "atistirmalik")
        case "Anne - Bebek & Çocuk":
            imageView.image = UIImage(named: "bebek")
        case "Ev & Yaşam":
            imageView.image = UIImage(named: "evyasam")
        case "Giyim & Ayakkabı & Aksesuar":
            imageView.image = UIImage(named: "giyimayakkabi")
        case "İçecek":
            imageView.image = UIImage(named: "icecek")
        default:
            imageView.image = UIImage(named: "sok")
        }
    }
    
    
    

}
