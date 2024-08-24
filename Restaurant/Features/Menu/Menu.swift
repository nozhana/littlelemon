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
    
    @State private var selectedItem: MenuItem?
    @State private var selectedCategory: MenuCategory?
    
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
        .ignoresSafeArea(edges: .top)
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
            FetchedObjects(predicate: viewModel.searchQuery.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title BEGINSWITH[cd] %@", viewModel.searchQuery)) { (dishes: [Dish]) in
                if dishes.isEmpty {
                    ForEach(0..<10, content: { _ in
                        MenuCard(item: .placeholder)
                            .redacted(reason: .placeholder)
                            .shimmering()
                    })
                } else {
                    ForEach(dishes.filter {
                        guard let selectedCategory else { return true }
                        return $0.category == selectedCategory.rawValue
                    }) { dish in
                        if let item = dish.menuItem {
                            MenuCard(item: item)
                                .onTapGesture {
                                    selectedItem = item
                                }
                                .sheet(item: $selectedItem, content: MenuDetail.init)
                        }
                    } // ForEach
                } // if/else
            } // FetchedObjects
        } // VStack
        .padding(.horizontal, 8)
    }
    
    private var menuBreakdownView: some View {
        VStack(alignment: .leading, spacing: 4) {
            Text("Order for delivery!")
                .textCase(.uppercase)
                .font(.sectionTitle)
                .foregroundStyle(theme.color[\.text.primary])
                .padding(.leading, 25)
            ScrollView(.horizontal) {
                HStack(spacing: 16) {
                    Spacer(minLength: 8)
                    ForEach(MenuCategory.allCases, id: \.hashValue) { category in
                        Text(category.rawValue.capitalized)
                            .font(.sectionContent)
                            .padding(.init(top: 6, leading: 8, bottom: 6, trailing: 8))
                            .foregroundStyle(theme.color[selectedCategory == category ? \.text.contrast : \.text.secondary])
                            .background(theme.color[selectedCategory == category ? \.surface.action : \.surface.secondary])
                            .clipShape(.roundedRect16)
                            .onTapGesture {
                                withAnimation {
                                    guard selectedCategory != category else {
                                        selectedCategory = nil
                                        return
                                    }
                                    selectedCategory = category
                                }
                            }
                    } // ForEach
                } // HStack
                .padding(.vertical, 16)
            } // ScrollView
        } // VStack
        .padding(.vertical, 16)
    }
    
    var body: some View {
        NavigationStack {
            ScrollView {
                LazyVStack(pinnedViews: .sectionHeaders) {
                    Section {
                        heroView
                        menuBreakdownView
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
    }
}

#Preview {
    Menu()
}
