//
//  AddProductVC.swift
//  ProductProject
//
//  Created by Nidhi on 10/03/24.
//

import UIKit

struct AddProduct:Codable {
    var id:Int? = nil
    let title:String
}

//struct ProductResponse: Decodable{
//    
//    let id:Int
//    let title:String
//    
//}

class AddProductVC: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

       //addProducts()
    }
    

    func addProducts() {
        
        guard let url = URL(string: "https://dummyjson.com/products/add") else { return }
        let parameters = AddProduct(title: "BMW Car")
        var request = URLRequest(url:url)
        request.httpMethod = "POST"
        request.httpBody = try? JSONEncoder().encode(parameters)
        request.allHTTPHeaderFields = [
            "Content-Type": "application/json"
        ]
        
        URLSession.shared.dataTask(with: request) { data, response, error in
            
            guard let data else { return }
            
            do {
                
                let productResponse = try JSONDecoder().decode(AddProduct.self, from: data)
                print(productResponse)
                
            }catch {
                print(error)
            }
            
        }.resume()
        
    }
    
  

}
