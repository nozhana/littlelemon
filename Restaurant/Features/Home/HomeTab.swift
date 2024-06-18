//
//  HomeTab.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import SwiftUI

enum HomeTab: BaseTabItem {
    case menu, profile
    
    var label: some View {
        switch self {
        case .menu:
            Label("Menu", systemImage: "list.dash")
        case .profile:
            Label("Profile", systemImage: "square.and.pencil")
        }
    }
}
