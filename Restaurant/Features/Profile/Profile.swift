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
    @EnvironmentObject private var theme: ThemeUtil
    
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
                    .foregroundStyle(theme.color[\.stroke.primary]) // TODO: Color.ripeLemon
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
        Text("Tap and hold to choose a new photo.")
            .font(.tagline)
            .foregroundStyle(theme.color[\.text.disabled])
            .padding(.vertical, 4)
    }
    
    private var logoutButton: some View {
        Button("Log out", systemImage: "rectangle.portrait.and.arrow.right", role: .destructive) {
            isShowingLogoutAlert = true
        }
        .buttonStyle(.borderedProminent)
        .font(.highlight)
    }
    
    @ViewBuilder
    private var logoutActions: some View {
        Button("Cancel", role: .cancel) {}
        Button("Logout", role: .destructive) {
            viewModel.updateProfileImage(nil)
            homeViewModel.logOut()
        }
    }
    
    private var editButton: some View {
        Button("Edit information", systemImage: "pencil") {
            viewModel.isEditing = true
        }
        .font(.highlight)
        .foregroundStyle(theme.color[\.text.secondary])
        .buttonStyle(.borderedProminent)
        .tint(theme.color[\.surface.secondary])
    }
    
    private var confirmButton: some View {
        Button("Confirm", systemImage: "checkmark.circle.fill") {
            guard viewModel.isEditing else { return }
            viewModel.editProfileInformation(.init(firstName: firstName, lastName: lastName, email: email))
            viewModel.isEditing = false
        }
        .font(.highlight)
        .buttonStyle(.borderedProminent)
    }
    
    private func makeTextField(systemImage: String, tag: String, content: Binding<String>, placeholder: String = "") -> some View {
        VStack(alignment: .leading) {
            TextField(placeholder, text: content)
                .font(.highlight)
                .foregroundStyle(theme.color[\.text.primary])
                .textFieldStyle(.plain)
                .padding()
                .background {
                    RoundedRectangle.roundedRect8
                        .fill(theme.color[viewModel.isEditing ? \.surface.secondary : \.surface.primary])
                }
                .disabled(!viewModel.isEditing)
            Label(tag, systemImage: systemImage)
                .imageScale(.large)
                .font(.caption)
                .foregroundStyle(theme.color[\.text.secondary])
        } // VStack
        .padding(.vertical, 8)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(pinnedViews: [.sectionHeaders, .sectionFooters]) {
                Section {
                    makeTextField(systemImage: "person", tag: "First name", content: $firstName)
                    makeTextField(systemImage: "person.fill", tag: "Last name", content: $lastName)
                    makeTextField(systemImage: "envelope", tag: "Email address", content: $email)
                } header: {
                    VStack {
                        profileImage
                        tooltip
                    } // VStack
                    .frame(width: UIScreen.main.bounds.width)
                    .background(.background)
                } footer: {
                    HStack {
                        logoutButton
                        Spacer()
                        if viewModel.isEditing {
                            confirmButton
                        } else {
                            editButton
                        }
                    } // HStack
                } // Section/footer
            } // LazyVStack
        } // ScrollView
        .scrollIndicators(.hidden)
        .padding(.horizontal, 24)
        .alert("Log out and clear all data?", isPresented: $isShowingLogoutAlert) {
            logoutActions
        }
        .onAppear {
            firstName = viewModel.firstName
            lastName = viewModel.lastName
            email = viewModel.email
        }
        .onDisappear {
            viewModel.isEditing = false
        }
        .navigationTitle("Profile")
    }
}

#Preview {
    Profile()
}
