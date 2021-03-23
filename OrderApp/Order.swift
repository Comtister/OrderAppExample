//
//  Order.swift
//  OrderApp
//
//  Created by Oguzhan Ozturk on 9.03.2021.
//

import Foundation

struct Order : Codable {
    
    var menuItems : [MenuItem]
    
    init(menuItems : [MenuItem] = []) {
        self.menuItems = menuItems
    }
    
}
