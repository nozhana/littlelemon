//
//  Image+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/16/24.
//

import SwiftUI

extension Image {
    var squareCropped: some View {
        GeometryReader { geo in
            self
                .resizable()
                .scaledToFill()
                .frame(width: min(geo.size.width, geo.size.height), height: min(geo.size.width, geo.size.height))
                .clipped()
        }
    }
}
