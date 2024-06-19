//
//  AnyColorTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

struct AnyColorTheme: ColorTheme {
    private let theme: ColorTheme
    
    init(_ colorTheme: ColorTheme) {
        self.theme = colorTheme
    }
    
    var surface: SurfaceColorTheme {
        theme.surface
    }
    
    var text: TextColorTheme {
        theme.text
    }
    
    var icon: IconColorTheme {
        theme.icon
    }
    
    var stroke: StrokeColorTheme {
        theme.stroke
    }
}

extension ColorTheme {
    func eraseToAnyColorTheme() -> AnyColorTheme {
        .init(self)
    }
}
