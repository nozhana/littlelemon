//
//  EditProfileForm.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/14/24.
//

import Foundation

struct EditProfileForm {
    let firstName: String?
    let lastName: String?
    let email: String?
    
    init(firstName: String? = nil, lastName: String? = nil, email: String? = nil) {
        self.firstName = firstName
        self.lastName = lastName
        self.email = email
    }
}
