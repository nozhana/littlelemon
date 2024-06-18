//  
//  ProfileViewModel.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
// 

import UIKit

class ProfileViewModel: BaseViewModel {
    @Inject(\.userDefaults, \.firstName) var firstName
    @Inject(\.userDefaults, \.lastName) var lastName
    @Inject(\.userDefaults, \.email) var email
    
    @Published var isEditing = false
    @Inject(\.fileUtil) private var fileUtil
    
    func editProfileInformation(_ form: EditProfileForm) {
        if let firstName = form.firstName {
            self.firstName = firstName
        }
        if let lastName = form.lastName {
            self.lastName = lastName
        }
        if let email = form.email {
            self.email = email
        }
        self.objectWillChange.send()
    }
    
    func updateProfileImage(_ image: UIImage) {
        fileUtil.write(image, name: "profile_image")
        self.objectWillChange.send()
    }
    
    func readProfileImage() -> UIImage? {
        fileUtil.read(image: "profile_image")
    }
}

extension Container {
    var profileViewModel: Factory<ProfileViewModel> {
        self { .init() }
            .unique
    }
}
