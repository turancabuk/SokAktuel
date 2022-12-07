//
//  MainViewController.swift
//  Aktuel
//
//  Created by Turan Çabuk on 28.11.2022.

import UIKit

class MainViewController: UIViewController {
    
    
    @IBOutlet weak var tableView: UITableView!
    @IBOutlet weak var collectionView: UICollectionView!
    
    var viewModel: MainViewModel?
    var chosenProduct: Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        tableView.delegate = self
        tableView.dataSource = self
        collectionView.delegate = self
        collectionView.dataSource = self
        
        let layout  = UICollectionViewFlowLayout()
        layout.scrollDirection = .horizontal
        layout.itemSize = CGSize(width: 100, height: 200)
        collectionView.collectionViewLayout = layout
        
        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        collectionView?.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
        viewModel = MainViewModel()
        
        guard let viewModel = viewModel else {return}
        viewModel.getProducts(completion: {result in
            DispatchQueue.main.async {
                self.tableView.reloadData()
                self.collectionView.reloadData()
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
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        chosenProduct = viewModel?.productList[indexPath.row]
        performSegue(withIdentifier: "toDetailsVC", sender: indexPath)
    }
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "toDetailsVC" {
            let destination = segue.destination as! ProductDetailViewController
            destination.selectedProduct = chosenProduct
        }
    }
}

extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel?.productList.count ?? 0
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        if let item = viewModel?.productList[indexPath.row] {
            cell.configCollectionView(with: item)
        }
        return cell
    }
    
}

extension MainViewController: UICollectionViewDelegateFlowLayout {
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100,
                      height: collectionView.frame.size.height)
    }
}


