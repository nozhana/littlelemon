//
//  MenuSearch.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/16/24.
//

import SwiftUI

struct MenuSearch: View {
    @Binding var searchQuery: String
    
    @State private var state: CustomTextFieldState = .normal
    @State private var selectedItem: MenuItem?
    @FocusState private var isFocused: Bool
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8, pinnedViews: .sectionHeaders) {
                Section {
                    FetchedObjects(predicate: searchQuery.isEmpty ? NSPredicate(value: true) : NSPredicate(format: "title CONTAINS[cd] %@", searchQuery)) { (dishes: [Dish]) in
                        ForEach(dishes) { dish in
                            if let item = dish.menuItem {
                                MenuCard(item: item)
                                    .onTapGesture {
                                        selectedItem = item
                                    }
                                    .sheet(item: $selectedItem, content: MenuDetail.init)
                            }
                        } // ForEach
                    } // FetchedObjects
                } header: {
                    TextField("Search items", text: $searchQuery)
                        .textFieldStyle(.customTextFieldStyle(state: $state, content: $searchQuery, placeholder: "", icon: "magnifyingglass", fixedHeight: true))
                        .focused($isFocused)
                } // Section
            } // LazyVStack
        } // ScrollView
        .scrollIndicators(.hidden)
        .padding(.init(top: 16, leading: 16, bottom: 0, trailing: 16))
        .onAppear {
            isFocused = true
        }
        .navigationTitle("Search")
    } // body
}

//#Preview {
//    MenuSearch()
//}
