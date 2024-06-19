//
//  SnackbarConfiguration.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

struct SnackbarConfiguration {
    let systemImage: String
    let content: String
}

extension SnackbarConfiguration {
    static var empty: Self { .init(systemImage: "", content: "") }
}
