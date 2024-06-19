//
//  ThemeUtil.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

class ThemeUtil: ObservableObject {
    fileprivate init() {}
    @Published var color: ColorTheme = .light
}

extension Container {
    var theme: Factory<ThemeUtil> {
        self { ThemeUtil() }
    }
}
