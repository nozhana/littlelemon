//
//  Transition+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/19/24.
//

import SwiftUI

extension AnyTransition {
    static var backslide: AnyTransition {
        .asymmetric(insertion: .move(edge: .trailing), removal: .move(edge: .leading))
    }
}
