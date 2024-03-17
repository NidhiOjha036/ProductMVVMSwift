//
//  ProductViewModel.swift
//  ProductProject
//
//  Created by Nidhi on 27/01/24.
//

import Foundation


final class ProductViewModel {
    
    var products:[Product] = []
    var eventHandler:((_ event: Event) -> ())?  //Data binding closure
    
    func fetchProducts() {
        
        APIManager.shared.request(
            modelType: [Product].self,
            type: ProductEndPoint.products) { response in
                switch response{
                case .success(let products):
                    self.products = products
                    self.eventHandler?(.dataLoaded)
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    
    func addProduct(parameters:AddProduct) {
        APIManager.shared.request(
            modelType: AddProduct.self,
            type: ProductEndPoint.addProduct(product: parameters)) { result in
                switch result{
                case .success(let product):
                    self.eventHandler?(.newProductAdded(product: product))
                case .failure(let error):
                    self.eventHandler?(.error(error))
                }
            }
    }
    
    


}

extension ProductViewModel {
    
    enum Event {
        
        case loading
        case stopLoading
        case dataLoaded
        case error(_ error:Error?)
        case newProductAdded(product:AddProduct)
        
    }
    
}
