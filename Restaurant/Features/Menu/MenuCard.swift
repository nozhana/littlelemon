//
//  MenuCard.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/18/24.
//

import SwiftUI

struct MenuCard: View {
    let item: MenuItem
    
    @EnvironmentObject private var theme: ThemeUtil
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 4) {
                Text(item.title)
                    .font(.cardTitle)
                    .foregroundStyle(theme.color[\.text.primary])
                Text(item.description)
                    .font(.body)
                    .foregroundStyle(theme.color[\.text.secondary])
                Spacer()
                Text("$\(item.price)")
                    .font(.highlight)
                    .foregroundStyle(theme.color[\.text.primary])
            } // VStack
            Spacer()
            AsyncImage(url: URL(string: item.image)) { image in
                image
                    .resizable()
                    .scaledToFill()
            } placeholder: {
                Rectangle()
                    .fill(.background)
                    .shimmering()
            }
            .frame(width: 140, height: 140)
            .scaledToFill()
            .clipShape(.roundedRect(4))
        } // HStack
        .padding()
        .background(RoundedRectangle.roundedRect8.fill(theme.color[\.surface.secondary]))
    }
}
