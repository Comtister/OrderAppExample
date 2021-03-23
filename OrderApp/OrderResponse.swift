//
//  OrderResponse.swift
//  OrderApp
//
//  Created by Oguzhan Ozturk on 9.03.2021.
//

import Foundation

struct OrderResponse : Codable{
    
    let prepTime : Int
    
    enum CodingKeys : String , CodingKey {
        case prepTime = "preparation_time"
    }
    
}
