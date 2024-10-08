//
//  Login.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import SwiftUI

enum OnboardingFocus {
    case firstName, lastName, email
}

struct Login: View {
    @StateObject private var viewModel = Inject[\.loginViewModel]
    
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var email: String = ""
    
    @FocusState private var focus: OnboardingFocus?
    @Environment(\.dismiss) private var dismiss
    
    @EnvironmentObject private var theme: ThemeUtil
    
    private func clearForm() {
        firstName = ""
        lastName = ""
        email = ""
    }
    
    var body: some View {
        VStack(spacing: 16) {
            Image("LittleLemonLogo", bundle: .main)
                .resizable()
                .scaledToFit()
                .frame(width: 240)
            if viewModel.isOnboarded,
               !viewModel.firstName.isEmpty {
                Spacer()
                Text("Welcome, \(viewModel.firstName.capitalized)!")
                    .font(.displayLarge)
                Spacer()
                Button("Continue", systemImage: "arrow.right") {
                    dismiss()
                }
                .buttonStyle(CustomButtonStyle(colors: theme.color, role: .prominent))
                Spacer()
            } else {
                Group {
                    TextField("Your first name", text: $firstName)
                        .keyboardType(.namePhonePad)
                        .focused($focus, equals: .firstName)
                        .onSubmit {
                            focus = .lastName
                        }
                        .submitLabel(.next)
                        .textFieldStyle(.customTextFieldStyle(state: $viewModel.firstNameState, content: $firstName, placeholder: "Your first name", icon: "person", errorMessage: viewModel.firstNameErrorMessage))
                    TextField("Your last name", text: $lastName)
                        .keyboardType(.namePhonePad)
                        .focused($focus, equals: .lastName)
                        .onSubmit {
                            focus = .email
                        }
                        .submitLabel(.next)
                        .textFieldStyle(.customTextFieldStyle(state: $viewModel.lastNameState, content: $lastName, placeholder: "Your last name", icon: "person.fill", errorMessage: viewModel.lastNameErrorMessage))
                    TextField("Your email address", text: $email)
                        .keyboardType(.emailAddress)
                        .focused($focus, equals: .email)
                        .onSubmit {
                            focus = nil
                            viewModel.submitForm(firstName: firstName, lastName: lastName, email: email)
                        }
                        .submitLabel(.done)
                        .textFieldStyle(.customTextFieldStyle(state: $viewModel.emailState, content: $email, placeholder: "Your email address", icon: "envelope", errorMessage: viewModel.emailErrorMessage))
                    Button("Submit") {
                        focus = nil
                        viewModel.submitForm(firstName: firstName, lastName: lastName, email: email)
                    }
                    .buttonStyle(CustomButtonStyle(colors: theme.color, role: .prominent))
                } // Group
            } // if
        } // VStack
        .padding()
    }
}

#Preview {
    Login()
}
