//
//  MainViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 28.11.2022.

import UIKit

class MainViewController: UIViewController {
   
    @IBOutlet weak var tableView: UITableView!
    
    var viewModel: MainViewModel?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        
        viewModel = MainViewModel()
        
        guard let viewModel = viewModel else {return}
        viewModel.getProducts(completion: {result in
            DispatchQueue.main.async {
                self.tableView.reloadData()
            }
        })
        
    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel?.productList.count ?? 5
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductListCellViewController = (tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductListCellViewController)!
        let article = viewModel?.productList[indexPath.row]
        cell.configCells(model: article!)
        return cell
    }
}

// [[UIView, new] autorelease];
