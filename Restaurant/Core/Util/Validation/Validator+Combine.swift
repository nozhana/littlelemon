//
//  Validator+Combine.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import Foundation
import Combine

extension Publisher where Failure == Never {
    func validate(_ validation: @escaping (Output) -> Validation) -> some Publisher<Validation, Never> {
        map(validation)
    }
    
    func publisher<V>(forValidator validator: V) -> some Publisher<Validation, Never> where V: Validator<Output> {
        return map(validator.validate)
    }
}

extension Publisher where Output == String, Failure == Never {
    func nonEmptyValidationPublisher(errorMessage: String? = nil) -> some Publisher<Validation, Never> {
        map(NonEmptyValidator(errorMessage: errorMessage).validate)
    }
    
    func emailValidationPublisher(errorMessage: String? = nil) -> some Publisher<Validation, Never> {
        map(EmailValidator(errorMessage: errorMessage).validate)
    }
    
    func phoneValidationPublisher(errorMessage: String? = nil) -> some Publisher<Validation, Never> {
        map(PhoneValidator(errorMessage: errorMessage).validate)
    }
}
