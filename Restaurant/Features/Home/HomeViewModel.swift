//
//  HomeViewModel.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import Foundation

class HomeViewModel: BaseViewModel {
    @Published var selectedTab: HomeTab = .menu
    @Published var isShowingOnboarding = false
    
    @Inject(\.userDefaults, \.isOnboarded) private var isOnboarded
    @Inject(\.userDefaults, \.firstName) private var firstName
    @Inject(\.userDefaults, \.lastName) private var lastName
    @Inject(\.userDefaults, \.email) private var email
    
    override init() {
        super.init()
        isShowingOnboarding = !isOnboarded
    }
    
    func logOut() {
        _firstName.clear()
        _lastName.clear()
        _email.clear()
        _isOnboarded.clear()
        isShowingOnboarding = true
    }
}

extension Container {
    var homeViewModel: Factory<HomeViewModel> {
        self { .init() }
            .unique
    }
}
