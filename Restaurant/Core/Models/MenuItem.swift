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
    let category: MenuCategory
    
    enum CodingKeys: CodingKey {
        case title
        case description
        case price
        case image
        case category
    }
}

extension MenuItem {
    init?(dish: Dish) {
        guard let title = dish.title,
              let description = dish.desc,
              let price = dish.price,
              let image = dish.image,
              let category = dish.category else { return nil }
        self.init(title: title, description: description, price: price, image: image, category: MenuCategory(rawValue: category) ?? .mains)
    }
}

extension Dish {
    var menuItem: MenuItem? {
        .init(dish: self)
    }
}

extension MenuItem {
    static var placeholder: Self {
        .init(title: "Lorem Ipsum", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Etiam ligula quam.", price: "10", image: "", category: .mains)
    }
}
