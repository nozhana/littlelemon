//
//  MenuCard.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/18/24.
//

import SwiftUI

struct MenuCard: View {
    let dish: Dish
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(dish.title ?? "Unnamed")
                    .font(.cardTitle)
                Text(dish.desc ?? "No description")
                    .font(.body)
                Spacer()
                Text("$\(dish.price ?? "--")")
                    .font(.highlight)
            } // VStack
            Spacer()
            AsyncImage(url: URL(string: dish.image ?? "")) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                ProgressView()
            }
            .frame(width: 140, height: 140)
            .scaledToFill()
            .clipShape(.roundedRect(4))
        } // HStack
        .padding()
        .background(RoundedRectangle.roundedRect8.fill(.thinMaterial))
    }
}
