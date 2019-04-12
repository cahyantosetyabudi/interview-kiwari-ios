//
//  AddProductViewController.swift
//  interview-kiwari-ios
//
//  Created by Cahyanto Setya Budi on 4/13/19.
//  Copyright © 2019 Cahyanto Setya Budi. All rights reserved.
//

import UIKit
import RxSwift

class AddProductViewController: UIViewController {
    
    let disposeBag = DisposeBag()
    
    var previous: String?
    var product: Product?

    @IBOutlet weak var productNameField: UITextField!
    @IBOutlet weak var productPriceField: UITextField!
    @IBOutlet weak var productImageField: UITextField!
    
    @IBAction func saveProductTapped(_ sender: UIButton) {
        guard let productName = productNameField.text else { return }
        guard let productPrice = productPriceField.text, let productPriceNumber = Int(productPrice) else { return }
        guard let productImage = productImageField.text else { return }
        
        if previous == "Detail" {
            let product = Product(id: self.product!.id, name: productName, price: productPriceNumber, imagePath: productImage)
            
            //Update product to API
            updateProduct(id: self.product!.id, requestBody: product)
        } else {
            let product = Product(id: 0, name: productName, price: productPriceNumber, imagePath: productImage)
            
            //Add product to API
            addProduct(requestBody: product)
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let product = product {
            productNameField.text = product.name
            productPriceField.text = "\(product.price)"
            productImageField.text = product.imagePath
        }
    }
}

// MARK: - AddProductViewController
extension AddProductViewController {
    private func addProduct(requestBody: Encodable) {
        provider.rx.request(.addProduct(requestBody))
            .map(BaseResponse<Product>.self)
            .subscribe { (event) in
                switch event {
                case .success(let response):
                    self.product = response.data
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    private func updateProduct(id: Int, requestBody: Encodable) {
        provider.rx.request(.updateProduct(id, requestBody))
            .map(BaseResponse<Product>.self)
            .subscribe { (event) in
                switch event {
                case .success(let response):
                    self.product = response.data
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
}
