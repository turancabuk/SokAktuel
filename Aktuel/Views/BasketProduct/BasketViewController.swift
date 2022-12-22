//
//  BasketViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 15.12.2022.
//

import UIKit
import CoreData

class BasketViewController: UIViewController {
    
    var viewModel: BasketViewModel!
    
    @IBOutlet weak var basketTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        
        basketTableView.delegate = self
        basketTableView.dataSource = self
        
        viewModel = BasketViewModel()
        viewModel?.getBasket()
        
    }
   
}
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.categorryArray.count ?? 3
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        let basketCell: BasketTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "basketCell") as? BasketTableViewCell)!
        basketCell.basketCategoryLabel.text = viewModel?.categorryArray[indexPath.row]
        basketCell.basketPriceLabel.text = "\(viewModel?.priceArray[indexPath.row])"
        basketCell.basketImageView.image = UIImage(named: "\(viewModel?.imageArray[indexPath.row])")
        return basketCell
    }
}


