//
//  ProductListVC.swift
//  ProductProject
//
//  Created by Nidhi on 27/01/24.
//

import UIKit

class ProductListVC: UIViewController {
    
    @IBOutlet weak var tblProduct: UITableView!
    private var viewModel = ProductViewModel()

    override func viewDidLoad() {
        super.viewDidLoad()

        configuration()
        
    }
    
    @IBAction func btnAddProductTapped(_ sender: UIBarItem) {
        let product = AddProduct(title: "iPhone")
        viewModel.addProduct(parameters: product)
    }
    

}

extension ProductListVC {
    
    func configuration(){
        
        tblProduct.dataSource = self
        tblProduct.register(UINib(nibName: "ProductCell", bundle: nil), forCellReuseIdentifier: "ProductCell")
        initViewModel()
        observeEvent()
        
    }
    
    func initViewModel(){
        viewModel.fetchProducts()
    }
    
    //Data binding event observe
    func observeEvent(){
        viewModel.eventHandler = { [weak self] event in
            
            guard let self else { return }
            
            switch event {
            case .loading:
                print("loading")
            case .stopLoading:
                print("stop loading")
            case .dataLoaded:
                print("data loaded")
                DispatchQueue.main.async {
                    self.tblProduct.reloadData()
                }
            case .error(let error):
                print(error)
            case .newProductAdded(let newProduct):
                print(newProduct)
            }
            
            
        }
    }
    
}

extension ProductListVC:UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        viewModel.products.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        guard let cell = tblProduct.dequeueReusableCell(withIdentifier: "ProductCell") as? ProductCell else { return UITableViewCell() }
        let product = viewModel.products[indexPath.row]
        cell.product = product
        return cell
    }
    
    
}
