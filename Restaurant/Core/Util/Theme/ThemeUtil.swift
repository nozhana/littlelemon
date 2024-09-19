//
//  ThemeUtil.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

class ThemeUtil: ObservableObject {
    fileprivate init() {}
    @Published var color: AnyColorTheme = .light
    @Published var gradient: AnyGradientTheme = .light
}

extension ThemeUtil {
    func apply(_ colorScheme: ColorScheme) {
        color = colorScheme == .dark ? .dark : .light
        gradient = colorScheme == .dark ? .dark : .light
    }
}

extension Container {
    var theme: Factory<ThemeUtil> {
        self { ThemeUtil() }
    }
}
