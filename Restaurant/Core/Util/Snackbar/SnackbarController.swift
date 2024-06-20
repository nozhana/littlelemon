//
//  SnackbarController.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/20/24.
//

import SwiftUI

class SnackbarController: ObservableObject {
    @Published var configuration: SnackbarConfiguration = .empty
    
    var isShowingSnackbar: Bool {
        get { configuration != .empty }
        set {
            if !newValue {
                withAnimation { 
                    configuration = .empty
                }
            }
        }
    }
    
    fileprivate init() {}
}

extension Container {
    var snackbar: Factory<SnackbarController> {
        self { SnackbarController() }
    }
}
