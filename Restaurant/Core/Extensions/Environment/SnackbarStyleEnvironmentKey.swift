//
//  SnackbarStyleEnvironmentKey.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

fileprivate struct SnackbarStyleEnvironmentKey: EnvironmentKey {
    static var defaultValue: AnySnackbarStyle {
        .default.eraseToAnySnackbarStyle()
    }
}

extension EnvironmentValues {
    var snackbarStyle: AnySnackbarStyle {
        get { self[SnackbarStyleEnvironmentKey.self] }
        set { self[SnackbarStyleEnvironmentKey.self] = newValue }
    }
}

extension View {
    func snackbarStyle<S>(_ style: S) -> some View where S: SnackbarStyle {
        environment(\.snackbarStyle, style.eraseToAnySnackbarStyle())
    }
}
