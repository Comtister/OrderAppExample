//
//  MenuController.swift
//  OrderApp
//
//  Created by Oguzhan Ozturk on 9.03.2021.
//

import Foundation

class MenuController {
    
    typealias MinutesToPrepare = Int
    
    let baseURL = URL(string: "http://localhost:8080/")!
    
    func fetchCategories(completion : @escaping (Result<[String] , Error>) -> Void) -> Void{
        
        let categorieURL = baseURL.appendingPathComponent("categories")
       
        let task = URLSession.shared.dataTask(with: categorieURL, completionHandler: { data,response,error in
            
            if let data = data{
                
                
                do{
                    
                    let jsonDecoder = JSONDecoder()
                    let categoriesResponse = try jsonDecoder.decode(CategoriesResponse.self, from: data)
                    completion(.success(categoriesResponse.categories))
                    
                }catch{
                    
                    completion(.failure(error))
                }
                
            }
            
        })
        
        task.resume()
    }
    
    func fetchMenuItems(forCategory categoryName: String,
       completion: @escaping (Result<[MenuItem], Error>) -> Void) {
        
        let baseMenuURL = baseURL.appendingPathComponent("menu")
        
        var components = URLComponents(url: baseMenuURL, resolvingAgainstBaseURL: true)!
        components.queryItems = [URLQueryItem(name: "category", value: categoryName)]
        let menuUrl = components.url!
        
        let task = URLSession.shared.dataTask(with: menuUrl, completionHandler: { data,response,errors in
            
            
            if let data = data{
                
                
                do{
                    
                    let jsonDecoder = JSONDecoder()
                    let menuResponse = try jsonDecoder.decode(MenuResponse.self, from: data)
                    
                    completion(.success(menuResponse.items))
                    
                }catch{
                    
                    completion(.failure(error))
                    
                }
                
            }
            
        })
        
        task.resume()
        
    }
    
    func submitOrder(forMenuIDs menuIDs: [Int], completion:
       @escaping (Result<MinutesToPrepare, Error>) -> Void) {
     
        let orderURL = baseURL.appendingPathComponent("order")
        
        var request = URLRequest(url: orderURL)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let data = ["menuIds" : menuIDs]
        let jsonEncoder = JSONEncoder()
        let jsonData = try? jsonEncoder.encode(data)
        
        let task = URLSession.shared.dataTask(with: request, completionHandler: { data,response,error in
            
            
            if let data = data{
                
                
                do{
                    
                    let jsonDecoder = JSONDecoder()
                    let orderResponse = try jsonDecoder.decode(OrderResponse.self, from: data)
                    completion(.success(orderResponse.prepTime))
                    
                }catch{
                    
                    
                }
                
            }
            
        })
        
    }
    

    
    
}
