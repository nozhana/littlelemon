//
//  MenuService.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Foundation

enum MenuService {
    case fetch
}

extension MenuService: Service {
    var baseURL: String {
        "https://raw.githubusercontent.com/Meta-Mobile-Developer-PC/Working-With-Data-API/main"
    }
    
    var path: String { "menu.json" }
}
