//
//  HomeViewController.swift
//  interview-kiwari-ios
//
//  Created by Cahyanto Setya Budi on 4/12/19.
//  Copyright © 2019 Cahyanto Setya Budi. All rights reserved.
//

import UIKit
import Kingfisher
import RxSwift

class HomeViewController: UIViewController {

    let disposeBag = DisposeBag()
    
    var products = [Product]()
    
    @IBOutlet weak var tableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        //Get list all products
        getProducts()
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowDetailProduct" {
            let viewController = segue.destination as! DetailProductViewController
            guard let indexPath = tableView.indexPathForSelectedRow else { return }
            viewController.product = products[indexPath.row]
        }
    }
}

// MARK: - HomeViewController
extension HomeViewController {
    private func getProducts() {
        provider.rx.request(.getProducts)
            .map(BaseResponse<[Product]>.self)
            .subscribe { (event) in
                switch event {
                case .success(let response):
                    self.products = response.data
                    self.tableView.reloadData()
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "ProductsCell", for: indexPath) as! HomeTableViewCell
        let product = products[indexPath.row]
        
        let imageURL = URL(string: product.imagePath)
        cell.productImage.kf.setImage(with: imageURL)
        
        cell.productNameLabel.text = product.name
        cell.productPriceLabel.text = "\(product.price)"
        
        return cell
    }
    
    
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {

}
