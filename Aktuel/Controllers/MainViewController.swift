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
    let menuView = UIView(frame: CGRect(x: 0, y: 100, width: 250, height: 666))
    let shopsButton = UIButton(frame: CGRect(x: 50, y: 50, width: 150, height: 40))
    let aboutUsButton = UIButton(frame: CGRect(x: 50, y: 100, width: 150, height: 40))



    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setupTableView()
        setupCollectionView()
        loadMenuView()
        aboutUsButtonClicked()
        shopsUsButtonClicked()

        
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
    
    @IBAction func menuButtonClicked(_ sender: Any) {
        
        if menuView.isHidden {
            menuView.isHidden = false
        } else {
            menuView.isHidden = true
        }
    }
}
extension MainViewController: UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {

        return viewModel.productList.count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {

        let cell: ProductListTableViewCell = productTableView.dequeueReusableCell(withIdentifier: "ProductCellIdentifier") as! ProductListTableViewCell
        let chosenProduct = viewModel.productList[indexPath.row]
        cell.configCells(model: chosenProduct)
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
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "ProductCollectionViewCell", for: indexPath) as! ProductCollectionViewCell
            let item = viewModel.categoryArray[indexPath.item]
        cell.configCollectionView(with: item)
            return cell
    }
    
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        
        return viewModel.categoryArray.count
    }
}
extension MainViewController: UICollectionViewDelegateFlowLayout {
        private func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout,
                            sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
            return CGSize(width: 100,
                          height: collectionView.frame.size.height)
    }
}
extension MainViewController {
    func loadMenuView() {
        view.addSubview(menuView)
        menuView.backgroundColor = UIColor.systemYellow
        menuView.isHidden = true
    }
    func aboutUsButtonClicked() {
        aboutUsButton.backgroundColor = UIColor.blue
        aboutUsButton.setTitle("About Us", for: .normal)
        aboutUsButton.setTitleColor(UIColor.white, for: .normal)
        aboutUsButton.addTarget(self, action: #selector(goToAboutUsPage), for: .touchUpInside)
        menuView.addSubview(aboutUsButton)
        
    }
    func shopsUsButtonClicked() {
        shopsButton.backgroundColor = UIColor.blue
        shopsButton.setTitle("Shops", for: .normal)
        shopsButton.setTitleColor(UIColor.white, for: .normal)
        shopsButton.addTarget(self, action: #selector(goToShopsPage), for: .touchUpInside)
        menuView.addSubview(shopsButton)
    }
    @objc func goToAboutUsPage() {
        guard let url = URL(string: "https://kurumsal.sokmarket.com.tr/hakkimizda") else { return }
        UIApplication.shared.open(url)
    }
    @objc func goToShopsPage() {
        guard let url = URL(string: "https://kurumsal.sokmarket.com.tr/magazalarimiz") else { return }
        UIApplication.shared.open(url)
    }
        
}
