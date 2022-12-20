//
//  MainViewController.swift
//  Aktuel
//  Created by Turan Çabuk on 28.11.2022.

import UIKit


class MainViewController: UIViewController {
    
    var viewModel: MainViewModel!
    
    
    @IBOutlet weak var logoImageView: UIImageView!
    @IBOutlet weak var productTableView: UITableView!
    @IBOutlet weak var categoriesCollectionView: UICollectionView!
    


    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        
        viewModel = MainViewModel()
        
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

    @IBAction func gotoBasket(_ sender: UIButton) {

    }
}

extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return viewModel.productList.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell: ProductListTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductListTableViewCell)!
        let product = viewModel?.productList[indexPath.row]
        cell.configCells(model: product!)
        cell.delegate = self
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

extension MainViewController: ProductListDelegate {
    func didSelectProduct() {
        print("istedigini yazdir")
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
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                        sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        return CGSize(width: 100,
                      height: collectionView.frame.size.height)
    }
}



