//
//  LoginViewModel.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import Foundation
import Combine

class LoginViewModel: BaseViewModel {
    @Published var firstNameState = LLTextFieldState.normal
    @Published var lastNameState = LLTextFieldState.normal
    @Published var emailState = LLTextFieldState.normal
    
    @Published var firstNameErrorMessage: String? = nil
    @Published var lastNameErrorMessage: String? = nil
    @Published var emailErrorMessage: String? = nil
    
    private let formSubject = PassthroughSubject<OnboardingForm, Never>()
    private let formValidation: AnyPublisher<OnboardingFormValidation, Never>
    
    @Inject(\.userDefaults, \.isOnboarded) var isOnboarded
    @Inject(\.userDefaults, \.firstName) var firstName
    @Inject(\.userDefaults, \.lastName) var lastName
    @Inject(\.userDefaults, \.email) var email
    
    override init() {
        self.formValidation = self.formSubject
            .map(\.firstName)
            .nonEmptyValidationPublisher(errorMessage: OnboardingError.firstNameRequired.message)
            .combineLatest(
                self.formSubject
                    .map(\.lastName)
                    .nonEmptyValidationPublisher(errorMessage: OnboardingError.lastNameRequired.message),
                self.formSubject
                    .map(\.email)
                    .publisher(forValidator:
                            .nonEmptyValidator(errorMessage: OnboardingError.emailRequired.message)
                            .emailValidator(errorMessage: OnboardingError.emailInvalid.message)
                    )
            )
            .map(OnboardingFormValidation.init)
            .eraseToAnyPublisher()
        
        super.init()
    }
    
    override func setupBindings() {
        super.setupBindings()
        self.formSubject.combineLatest(self.formValidation)
            .receive(on: DispatchQueue.main)
            .sink { [weak self] form, formValidation in
                guard let self else { return }
                if !formValidation.firstName.isValid {
                    firstNameErrorMessage = formValidation.firstName.errorMessage
                    firstNameState = .error
                } else if firstNameState == .error {
                    firstNameState = .normal
                    firstNameErrorMessage = nil
                }
                
                if !formValidation.lastName.isValid {
                    lastNameErrorMessage = formValidation.lastName.errorMessage
                    lastNameState = .error
                } else if lastNameState == .error {
                    lastNameState = .normal
                    lastNameErrorMessage = nil
                }
                
                if !formValidation.email.isValid {
                    emailErrorMessage = formValidation.email.errorMessage
                    emailState = .error
                } else if emailState == .error {
                    emailState = .normal
                    emailErrorMessage = nil
                }
                
                if formValidation.isValid {
                    firstName = form.firstName
                    lastName = form.lastName
                    email = form.email
                    isOnboarded = true
                    self.objectWillChange.send()
                }
            }
            .store(in: &disposeBag)
    }
    
    func submitForm(firstName: String, lastName: String, email: String) {
        let form = OnboardingForm(firstName: firstName, lastName: lastName, email: email)
        formSubject.send(form)
    }
    
    func clearData() {
        _firstName.clear()
        _lastName.clear()
        _email.clear()
        _isOnboarded.clear()
        self.objectWillChange.send()
    }
}

struct OnboardingForm {
    let firstName: String
    let lastName: String
    let email: String
}

struct OnboardingFormValidation {
    let firstName: Validation
    let lastName: Validation
    let email: Validation
    
    var isValid: Bool {
        firstName.isValid && lastName.isValid && email.isValid
    }
}

enum OnboardingError {
    case firstNameRequired, lastNameRequired, emailRequired, emailInvalid
    
    var message: String {
        switch self {
        case .firstNameRequired:
            return "First name is required"
        case .lastNameRequired:
            return "Last name is required"
        case .emailRequired:
            return "Email is required"
        case .emailInvalid:
            return "Invalid email format"
        }
    }
}

extension DefaultsContainer {
    var isOnboarded: Factory<Bool> {
        self { false }
            .key("isOnboarded")
    }
    
    var firstName: Factory<String> {
        self { "" }
            .key("firstName")
    }
    
    var lastName: Factory<String> {
        self { "" }
            .key("lastName")
    }
    
    var email: Factory<String> {
        self { "" }
            .key("email")
    }
}

extension Container {
    var loginViewModel: Factory<LoginViewModel> {
        self { LoginViewModel() }
            .unique
    }
}
