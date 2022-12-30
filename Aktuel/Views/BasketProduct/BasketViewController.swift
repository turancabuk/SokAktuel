//
//  BasketViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 15.12.2022.
//

import UIKit
import CoreData

class BasketViewController: UIViewController {
    
    var viewModel: BasketViewModel! = BasketViewModel()
    
    @IBOutlet weak var basketTableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        basketTableView.delegate = self
        basketTableView.dataSource = self
        viewModel?.getBasket()
    }
    override func viewWillAppear(_ animated: Bool) {
        viewModel.getBasket()
        DispatchQueue.main.async {
            self.basketTableView.reloadData()
        }
        
    }
}
extension BasketViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: BasketTableViewCell = tableView.dequeueReusableCell(withIdentifier: "basketCell2") as! BasketTableViewCell
        let model = (viewModel.productList[indexPath.row])
        cell.configCell(model: model)
        return cell
    }
}


