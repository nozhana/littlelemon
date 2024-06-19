//
//  SnackbarStyle.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

protocol SnackbarStyle {
    associatedtype Content: View
    @ViewBuilder
    func makeBody(_ configuration: SnackbarConfiguration) -> Content
}

