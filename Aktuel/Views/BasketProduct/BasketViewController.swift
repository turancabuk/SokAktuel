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
    func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete{
            
            let appDelegate = UIApplication.shared.delegate as! AppDelegate
            let context = appDelegate.persistentContainer.viewContext
            let product = viewModel?.productList[indexPath.row]
            context.delete(product!)
            do {
                try context.save()
                viewModel?.productList.remove(at: indexPath.row)
                tableView.deleteRows(at: [indexPath], with: .fade)
            } catch {
                print("error! \(error.localizedDescription)")
            }
        }
    }
}


