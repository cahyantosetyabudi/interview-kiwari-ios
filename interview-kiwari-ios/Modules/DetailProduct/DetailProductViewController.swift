//
//  DetailProductViewController.swift
//  interview-kiwari-ios
//
//  Created by Cahyanto Setya Budi on 4/13/19.
//  Copyright © 2019 Cahyanto Setya Budi. All rights reserved.
//

import UIKit
import RxSwift

class DetailProductViewController: UIViewController {
    
    let disposeBag = DisposeBag()

    var product: Product?
    
    @IBOutlet weak var productNameLabel: UILabel!
    @IBOutlet weak var productPriceLabel: UILabel!
    @IBOutlet weak var productImageLabel: UILabel!
    
    @IBAction func deleteButtonTapped(_ sender: UIButton) {
        guard let product = product else { return }
        provider.rx.request(.deleteProduct(product.id))
            .map(BaseResponse<[String?]>.self)
            .subscribe { (event) in
                switch event {
                case .success( _):
                    print("Sukses delete data")
                case .error(let error):
                    print(error.localizedDescription)
                }
            }
            .disposed(by: disposeBag)
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        if let product = product {
            productNameLabel.text = product.name
            productPriceLabel.text = "\(product.price)"
            productImageLabel.text = product.imagePath
        }
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "ShowUpdate" {
            let viewController = segue.destination as! AddProductViewController
            viewController.product = product
            viewController.previous = "Detail"
        }
    }
}
