//
//  MainViewController.swift
//  Aktuel
//  Created by Turan Çabuk on 28.11.2022.

import UIKit


class MainViewController: UIViewController {
    
    var viewModel: MainViewModel! = MainViewModel()
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        
        
        viewModel.getProducts(completion: { [weak self] in
            DispatchQueue.main.async {
                self?.productTableView.reloadData()
                self?.categoriesCollectionView.reloadData()
            }
        })
    }
    
    private func setupTableView() {
        productTableView.delegate = self
        productTableView.dataSource = self
    }
    
    private func setupCollectionView() {
        categoriesCollectionView.delegate = self
        categoriesCollectionView.dataSource = self
        
        let collectionViewLayout  = UICollectionViewFlowLayout()
        collectionViewLayout.scrollDirection = .horizontal
        collectionViewLayout.itemSize = CGSize(width: 100, height: 200)
        categoriesCollectionView.collectionViewLayout = collectionViewLayout

        let nib = UINib(nibName: "ProductCollectionViewCell", bundle: nil)
        categoriesCollectionView?.register(nib, forCellWithReuseIdentifier: "ProductCollectionViewCell")
    }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        guard let selectedIndexPath = (categoriesCollectionView.indexPathsForSelectedItems?.first) else { return 0 }
        if let count = (categoriesCollectionView as UICollectionView).cellForItem(at: selectedIndexPath)?.tag {
            return count
        }
        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductListTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductListTableViewCell)!
        let product = viewModel?.productList[indexPath.row]
        cell.configCells(model: product!)
        return cell
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if let chosenProduct = viewModel?.productList[indexPath.row] {
            let storyboard = UIStoryboard(name: "Main", bundle: nil)
            let vc = storyboard.instantiateViewController(withIdentifier: "ProductDetailViewController") as! ProductDetailViewController
            vc.viewModel = ProductDetailViewModel(selectedProduct: chosenProduct)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
extension MainViewController: UICollectionViewDelegate, UICollectionViewDataSource {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return viewModel.categoryArray.count
    }

    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        guard let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as? ProductCollectionViewCell else { return UICollectionViewCell() }
        if let item = viewModel?.categoryArray[indexPath.row]  {
            cell.configCollectionView(with: item)
        }
        return cell
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
        private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 100,
                          height: collectionView.frame.size.height)
        
    }
}
