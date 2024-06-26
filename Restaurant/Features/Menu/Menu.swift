//
//  Menu.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import SwiftUI

struct Menu: View {
    @StateObject private var viewModel = Inject[\.menuViewModel]
    
    @Environment(\.managedObjectContext) private var viewContext
    @EnvironmentObject private var theme: ThemeUtil
    
    private var profileImageView: some View {
        if let profileImage = viewModel.profileImage {
            Image(uiImage: profileImage)
                .resizable()
        } else {
            Image("profile", bundle: .main)
                .resizable()
        }
    }
    
    private var headerView: some View {
        HStack {
            Spacer()
                .frame(width: 44, height: 44)
            Spacer()
            Image("LittleLemonLogo", bundle: .main)
            Spacer()
            profileImageView
                .scaledToFill()
                .frame(width: 44, height: 44)
                .background(theme.color[\.surface.secondary])
                .clipShape(Circle())
        } // HStack
        .padding(.init(top: 20, leading: 24, bottom: 20, trailing: 24))
        .background(theme.color[\.surface.primary]) // TODO: Color.background
    }
    
    private var heroView: some View {
        VStack(alignment: .leading, spacing: 18) {
            VStack(alignment: .leading, spacing: 2) {
                Text("Little Lemon")
                    .font(.displayLarge)
                    .foregroundStyle(theme.color[\.text.title]) // TODO: Color.title
                Text("Chicago")
                    .font(.subtitle)
                    .foregroundStyle(theme.color[\.text.contrast]) // TODO: Color.contrast
            } // VStack
            HStack(spacing: 18) {
                Text("We are a family-owned Mediterranean restaurant, focused on traditional recipes served with a modern twist.")
                    .font(.leadText)
                    .foregroundStyle(theme.color[\.text.contrast]) // TODO: Color.contrast
                Image("hero", bundle: .main)
                    .resizable()
                    .scaledToFill()
                    .frame(width: 180, height: 180)
                    .clipShape(.roundedRect16)
            } // HStack
            NavigationLink {
                MenuSearch(searchQuery: $viewModel.searchQuery)
            } label: {
                TextField("Search items", text: $viewModel.searchQuery)
                    .textFieldStyle(.llTextFieldStyle(state: $viewModel.searchState, content: $viewModel.searchQuery, placeholder: "", icon: "magnifyingglass", fixedHeight: true))
            } // NavigationLink
            .buttonStyle(.plain)
        } // VStack
        .padding(24)
        .background(theme.color[\.surface.hero]) // TODO: Color.nandor
    }
    
    private var menuListView: some View {
        VStack {
            FetchedObjects { (dishes: [Dish]) in
                if dishes.isEmpty {
                    Text("Loading")
                        .font(.highlight)
                        .foregroundStyle(theme.color[\.text.secondary])
                        .padding(.top, 16)
                    ProgressView()
                }
                ForEach(viewModel.searchQuery.isEmpty ? dishes : dishes.filter { ($0.title?.lowercased().contains(viewModel.searchQuery.lowercased()) ?? true) || ($0.desc?.lowercased().contains(viewModel.searchQuery.lowercased()) ?? true)}) { dish in
                    MenuCard(dish: dish)
                } // ForEach
            } // FetchedObjects
        } // VStack
        .padding(.horizontal, 8)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    Section {
                        heroView
                        Text("Order for delivery!")
                        menuListView
                    } header: {
                        headerView
                    } // Section
                } // LazyVStack
            } // ScrollView
            .padding(.vertical, 0.1)
        } // NavigationStack
        .onReceive(viewModel.$menuList) { output in
            guard let output else { return }
            viewModel.persistMenu(output.menu, context: viewContext)
        }
        .snackbar($viewModel.isShowingSnackbar, configuration: viewModel.snackbarConfiguration ?? .empty)
    }
}

#Preview {
    Menu()
}
