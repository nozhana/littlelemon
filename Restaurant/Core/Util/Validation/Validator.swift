//
//  Validator.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import Foundation

enum Validation: Equatable {
    case valid
    case invalid(message: String? = nil)
}

extension Validation {
    var isValid: Bool {
        self == .valid
    }
    
    var errorMessage: String? {
        if case .invalid(let message) = self {
            return message
        }
        return nil
    }
}

protocol Validator<Content> {
    associatedtype Content
    func validate(_ content: Content) -> Validation
}

struct AnyValidator<C>: Validator {
    private let validation: (C) -> Validation
    
    init<V>(_ validator: V) where V: Validator<C> {
        self.validation = validator.validate
    }
    
    func validate(_ content: C) -> Validation {
        validation(content)
    }
}

extension Validator {
    func eraseToAnyValidator() -> AnyValidator<Content> { .init(self) }
}

struct GeneralValidator<C>: Validator {
    private let validation: (C) -> Validation
    
    init(validation: @escaping (C) -> Validation) {
        self.validation = validation
    }
    
    func validate(_ content: C) -> Validation {
        validation(content)
    }
}

extension Validator {
    func chain<V>(toValidator validator: V) -> some Validator<Content> where V: Validator<Content> {
        GeneralValidator<Content> { content in
            let validation = self.validate(content)
            return validation.isValid ? validator.validate(content) : validation
        }
    }
    
    func validator(validation: @escaping (Content) -> Validation) -> some Validator<Content> {
        let validator = GeneralValidator(validation: validation)
        return chain(toValidator: validator)
    }
}
