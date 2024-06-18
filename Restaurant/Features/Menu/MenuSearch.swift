//
//  MenuSearch.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/16/24.
//

import SwiftUI

struct MenuSearch: View {
    @Binding var searchQuery: String
    
    @State private var state: LLTextFieldState = .normal
    @FocusState private var isFocused: Bool
    
    @Environment(\.dismiss) private var dismiss
    
    private var backButton: some View {
        Button("Back", systemImage: "chevron.left") {
            dismiss()
        }
        .font(.highlight)
        .buttonStyle(.borderedProminent)
    }
    
    var body: some View {
        ScrollView {
            LazyVStack(spacing: 8, pinnedViews: [.sectionHeaders, .sectionFooters]) {
                Section {
                    FetchedObjects { (dishes: [Dish]) in
                        ForEach(dishes) { dish in
                            MenuCard(dish: dish)
                        } // ForEach
                    } // FetchedObjects
                } header: {
                    TextField("Search items", text: $searchQuery)
                        .textFieldStyle(.llTextFieldStyle(state: $state, content: $searchQuery, placeholder: "", icon: "magnifyingglass", fixedHeight: true))
                        .focused($isFocused)
                } footer: {
                    HStack {
                        Spacer()
                        backButton
                    } // HStack
                } // Section
            } // LazyVStack
        } // ScrollView
        .padding(.init(top: 20, leading: 12, bottom: 1, trailing: 12))
        .toolbar(.hidden)
        .scrollDismissesKeyboard(.never)
        .onAppear {
            isFocused = true
        }
    } // body
}

//#Preview {
//    MenuSearch()
//}
