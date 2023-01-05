//
//  MainViewController.swift
//  Aktuel
//  Created by Turan Çabuk on 28.11.2022.

import UIKit


class MainViewController: UIViewController {
    
    var viewModel: MainViewModel! = MainViewModel()
    var dataSource: [Product] = []
    
    
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


        return dataSource.count
        //        guard let selectedIndexPath = (categoriesCollectionView.indexPathsForSelectedItems?.first) else {return 0}
//        if let count = (categoriesCollectionView as UICollectionView).cellForItem(at: selectedIndexPath)?.tag {
//            return count
//        }
//        return 0
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        
        let cell = tableView.dequeueReusableCell(withIdentifier: "Cell") as! ProductListTableViewCell
        let item = dataSource[indexPath.row]
        cell.configCells(model: item)
        return cell
        
        
        //        let cell: ProductListTableViewCell = (tableView.dequeueReusableCell(withIdentifier: "Cell") as? ProductListTableViewCell)!
//        let product = viewModel?.productList[indexPath.row]
//        cell.configCells(model: product!)
//        return cell
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
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let cell = categoriesCollectionView.cellForItem(at: indexPath) as! ProductCollectionViewCell
        if cell.categoryLabel.text == "Yemeklik Malzemeler" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.foodMaterialProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Anne - Bebek & Çocuk" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.motherBabyChildProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "kahvaltılık" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.breakfastProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Giyim & Ayakkabı & Aksesuar" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.ClothingShoesAccessoryProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Kişisel Bakım & Kozmetik" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.PersonalCareCosmeticsProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Ev & Yaşam" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.homeLifeProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Temizlik" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.cleaningProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Süt & Süt Ürünleri" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.milkProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Dondurulmuş Ürünler" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.frozenproducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Kağıt Ürünleri" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.paperproducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Elektronik" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.electronicProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "İçecek" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.beverageProducts
            productTableView.reloadData()
        }
        else if cell.categoryLabel.text == "Atıştırmalık" {
            let viewModel = MainViewModel()
            self.dataSource = viewModel.snackProducts
            productTableView.reloadData()
        }
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
        private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 100,
                          height: collectionView.frame.size.height)
    }
}
