//
//  Profile.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import SwiftUI
import PhotosUI


struct Profile: View {
    @StateObject private var viewModel = Inject[\.profileViewModel]
    @EnvironmentObject private var homeViewModel: HomeViewModel
    @Environment(\.colorTheme) private var colorTheme
    
    @State private var firstName = ""
    @State private var lastName = ""
    @State private var email = ""
    @State private var isShowingPhotosPicker = false
    @State private var photosPickerItem: PhotosPickerItem?
    @State private var isShowingLogoutAlert = false
    
    private var currentProfileImage: Image {
        if let image = viewModel.readProfileImage() {
            return Image(uiImage: image)
        } else {
            return Image("profile", bundle: .main)
        }
    }
    
    private var profileImage: some View {
        currentProfileImage
            .resizable()
            .scaledToFill()
            .frame(width: 128, height: 128)
            .clipShape(Circle())
            .overlay {
                Circle()
                    .strokeBorder(lineWidth: 4)
                    .foregroundStyle(.yellow) // TODO: Color.ripeLemon
            }
            .contextMenu {
                Button("Choose a photo", systemImage: "photo.fill") {
                    isShowingPhotosPicker = true
                }
            } preview: {
                currentProfileImage
                    .resizable()
                    .scaledToFit()
            }
            .padding()
            .onChange(of: photosPickerItem) { newValue in
                Task {
                    homeViewModel.selectedTab = .profile
                    guard let loaded = try? await newValue?.loadTransferable(type: Image.self),
                          let uiImage = ImageRenderer(content: loaded.squareCropped.frame(width: 250, height: 250)).uiImage else { return }
                    viewModel.updateProfileImage(uiImage)
                }
            }
            .photosPicker(isPresented: $isShowingPhotosPicker, selection: $photosPickerItem, photoLibrary: .shared())
    }
    
    private var tooltip: some View {
        Text("Hold your avatar to choose a new photo.")
            .font(.tagline)
            .foregroundStyle(.secondary)
    }
    
    private var logoutButton: some View {
        Button("Log out", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive) {
            isShowingLogoutAlert = true
        }
        .buttonStyle(.borderedProminent)
        .font(.highlight)
        .padding()
    }
    
    @ViewBuilder
    private var logoutActions: some View {
        Button("Cancel", role: .cancel) {}
        Button("Logout", role: .destructive) {
            homeViewModel.logOut()
        }
    }
    
    private var editButton: some View {
        Button("Edit information", systemImage: "pencil") {
            viewModel.isEditing = true
        }
        .font(.highlight)
        .buttonStyle(.bordered)
    }
    
    private var confirmButton: some View {
        Button("Confirm", systemImage: "checkmark.circle.fill") {
            guard viewModel.isEditing else { return }
            viewModel.editProfileInformation(.init(firstName: firstName, lastName: lastName, email: email))
            viewModel.isEditing = false
        }
        .font(.highlight)
        .buttonStyle(.bordered)
    }
    
    private func makeRow(systemImage: String, tag: String, content: Binding<String>, placeholder: String = "") -> some View {
        HStack {
            Label(tag, systemImage: systemImage)
                .imageScale(.large)
                .font(.body)
            Spacer()
            TextField(placeholder, text: content)
                .font(.highlight)
                .textFieldStyle(.plain)
                .padding()
                .background {
                    if viewModel.isEditing {
                        RoundedRectangle.roundedRect8
                            .fill(.black.opacity(0.06))
                    }
                }
                .frame(width: 160)
                .disabled(!viewModel.isEditing)
        }
    }
    
    var body: some View {
        VStack(spacing: 8) {
            tooltip
            profileImage
            makeRow(systemImage: "person", tag: "First name", content: $firstName)
            makeRow(systemImage: "person.fill", tag: "Last name", content: $lastName)
            makeRow(systemImage: "envelope", tag: "Email address", content: $email)
            if viewModel.isEditing {
                confirmButton
            } else {
                editButton
            }
            logoutButton
        }
        .padding(.horizontal, 24)
        .alert("Log out and clear all data?", isPresented: $isShowingLogoutAlert) {
            logoutActions
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
        }
    }
}

#Preview {
    Profile()
}
