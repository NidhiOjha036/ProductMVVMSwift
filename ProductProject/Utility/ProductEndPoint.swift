//
//  ProductEndPoint.swift
//  ProductProject
//
//  Created by Nidhi on 17/03/24.
//

import Foundation

enum ProductEndPoint {
    case products //Module
    case addProduct(product:AddProduct)
}

extension ProductEndPoint:EndPointType {
   
    
    var path: String {
        switch self {
        case .products:
            return "products"
        case .addProduct:
            return "products/add"
        }
    }
    
    var baseURL: String {
        
        switch self {
        case .products:
            return "https://fakestoreapi.com/"
        case .addProduct:
            return "https://dummyjson.com/"
        }
         
        
    }
    
    var url: URL? {
        return URL(string: "\(baseURL)\(path)")
    }
    
    var method: HTTPMethods {
        switch self {
        case .products:
            return .get
        case .addProduct:
            return .post
        }
    }
    
    var body: Encodable? {
        switch self {
        case .products:
            return nil
        case .addProduct(let product):
            return product
        }
    }
    
    var headers: [String : String]? {
        return APIManager.commonHeaders
    }
    
    
}
