//
//  MenuItem.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Foundation

struct MenuItem: Codable, Identifiable, Hashable {
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

extension MenuItem {
    init?(dish: Dish) {
        guard let title = dish.title,
              let description = dish.desc,
              let price = dish.price,
              let image = dish.image else { return nil }
        self.init(title: title, description: description, price: price, image: image)
    }
}

extension Dish {
    var menuItem: MenuItem? {
        .init(dish: self)
    }
}
