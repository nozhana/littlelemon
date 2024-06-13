//
//  Validators.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import Foundation

struct NonEmptyValidator: Validator {
    private let errorMessage: String?
    
    init(errorMessage: String? = nil) {
        self.errorMessage = errorMessage
    }
    
    func validate(_ content: String) -> Validation {
        content.isEmpty ? .invalid(message: errorMessage ?? "Required field") : .valid
    }
}

struct EmailValidator: Validator {
    private let errorMessage: String?
    
    init(errorMessage: String? = nil) {
        self.errorMessage = errorMessage
    }
    
    func validate(_ content: String) -> Validation {
        if content.isEmpty {
            return .invalid(message: errorMessage ?? "Invalid email format")
        }
        let emailRegex = "[A-Z0-9a-z._%+-]+@[A-Za-z0-9.-]+\\.[A-Za-z]{2,64}"
        let predicate = NSPredicate(format: "SELF MATCHES %@", emailRegex)
        return predicate.evaluate(with: content)
        ? .valid
        : .invalid(message: errorMessage ?? "Invalid email format")
    }
}

struct PhoneValidator: Validator {
    private let errorMessage: String?
    
    init(errorMessage: String? = nil) {
        self.errorMessage = errorMessage
    }
    
    func validate(_ content: String) -> Validation {
        if content.isEmpty {
            return .invalid(message: errorMessage ?? "Invalid phone number")
        }
        let phoneRegex = "^[0-9+]{0,1}+[0-9]{5,16}$"
        let predicate = NSPredicate(format: "SELF MATCHES %@", phoneRegex)
        return predicate.evaluate(with: content)
        ? .valid
        : .invalid(message: errorMessage ?? "Invalid phone number")
    }
}

extension Validator where Content == String {
    func nonEmptyValidator(errorMessage: String? = nil) -> some Validator<Content> {
        chain(toValidator: NonEmptyValidator(errorMessage: errorMessage))
    }
    
    func emailValidator(errorMessage: String? = nil) -> some Validator<Content> {
        chain(toValidator: EmailValidator(errorMessage: errorMessage))
    }
    
    func phoneValidator(errorMessage: String? = nil) -> some Validator<Content> {
        chain(toValidator: PhoneValidator(errorMessage: errorMessage))
    }
}

extension Validator where Self == AnyValidator<String> {
    static func nonEmptyValidator(errorMessage: String? = nil) -> some Validator<Content> {
        NonEmptyValidator(errorMessage: errorMessage)
    }
    
    static func emailValidator(errorMessage: String? = nil) -> some Validator<Content> {
        EmailValidator(errorMessage: errorMessage)
    }
    
    static func phoneValidator(errorMessage: String? = nil) -> some Validator<Content> {
        PhoneValidator(errorMessage: errorMessage)
    }
}
