//
//  Shape+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import SwiftUI

extension Shape where Self == RoundedRectangle {
    static var roundedRect8: Self { .init(cornerSize: .init(width: 8, height: 8)) }
    static var roundedRect16: Self { .init(cornerSize: .init(width: 16, height: 16)) }
    
    static func roundedRect(_ cornerSize: CGFloat) -> Self {
        .init(cornerSize: .init(width: cornerSize, height: cornerSize))
    }
}
