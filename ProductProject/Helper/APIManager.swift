//
//  APIManager.swift
//  ProductProject
//
//  Created by Nidhi on 26/01/24.
//

import UIKit

//Single Design Pattern
//final -> Inheritance is not allowed
//private init -> Class instantiation is not possible outside the class


enum DataError:Error {
    case invalidResponse
    case invalidURL
    case invalidData
    case network(_ error: Error?)
}

//typealias Handler = (Result <[Product], DataError>) -> Void

typealias Handler<T> = (Result <T, DataError>) -> Void

final class APIManager {
    
    static let shared = APIManager()
    private init(){}
    
    
    func request<T:Decodable> (
        modelType: T.Type,
        type:EndPointType,
        completion: @escaping Handler<T>
    ){
        
        guard let url = type.url else {
            completion(.failure(.invalidURL))
            return
        }
        
        URLSession.shared.dataTask(with: url) { data, response, error in
            
            guard let data else {
                completion(.failure(.invalidData))
                return
            }
            
            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
                completion(.failure(.invalidResponse))
                return
            }
            
            //JSONDecoder()  - convert data into model
            do {
                let products = try JSONDecoder().decode(modelType, from: data)
                completion(.success(products))
            }catch {
                completion(.failure(.network(error)))
            }
            
        }.resume()
        
        
    }
    
    
    
    
    
    
    
    
//
//    func fetchProducts(completion: @escaping Handler ) {
//        
//        guard let url = URL(string: Constant.API.productURL) else {
//            return
//        }
//
//        URLSession.shared.dataTask(with: url) { data, response, error in
//            
//            guard let data else {
//                completion(.failure(.invalidData))
//                return
//            }
//            
//            guard let response = response as? HTTPURLResponse, 200 ... 299 ~= response.statusCode else {
//                completion(.failure(.invalidResponse))
//                return
//            }
//            
//            //JSONDecoder()  - convert data into model
//            do {
//                let products = try JSONDecoder().decode([Product].self, from: data)
//                completion(.success(products))
//            }catch {
//                completion(.failure(.network(error)))
//            }
//            
//        }.resume()
//    }
    
}


