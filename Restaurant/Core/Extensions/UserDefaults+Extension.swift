//
//  UserDefaults+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/11/24.
//

import Foundation

extension UserDefaults {
    static var shared: UserDefaults {
        let combined = UserDefaults.standard
        combined.addSuite(named: "group.littlelemon.restaurant")
        return combined
    }
}
