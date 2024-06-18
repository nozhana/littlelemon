//
//  MenuItem.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Foundation

struct MenuItem: Codable, Identifiable {
    var id = UUID()
    let title: String
    let description: String
    let price: String
    let image: String
    
    enum CodingKeys: CodingKey {
        case title
        case description
        case price
        case image
    }
}
