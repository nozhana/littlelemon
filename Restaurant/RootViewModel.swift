//
//  RootViewModel.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/11/24.
//

import Foundation

class RootViewModel: BaseViewModel {
    @Inject(\.userDefaults, \.isOnboarded) var isOnboarded
    @Inject(\.userDefaults, \.firstName) var firstName
    @Inject(\.userDefaults, \.lastName) var lastName
    @Inject(\.userDefaults, \.email) var email
    
    func clearData() {
        _firstName.clear()
        _lastName.clear()
        _email.clear()
        _isOnboarded.clear()
        self.objectWillChange.send()
    }
}

extension Container {
    var rootViewModel: Factory<RootViewModel> {
        self {
            RootViewModel()
        }
    }
}
