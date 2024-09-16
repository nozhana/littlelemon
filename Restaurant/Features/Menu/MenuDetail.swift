//
//  MenuDetail.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/21/24.
//

import SwiftUI

struct MenuDetail: View {
    let item: MenuItem
    
    @State private var magnification = 1.0
    
    @State private var isShowingComingSoon = false
    
    @Environment(\.dismiss) private var dismiss
    
    private var magnificationGesture: some Gesture {
        MagnificationGesture()
            .onChanged { value in
                magnification = max(value, 1)
            }
            .onEnded { _ in
                withAnimation(.bouncy) {
                    magnification = 1.0
                }
            }
    }
    
    var body: some View {
        GeometryReader { geo in
            VStack(spacing: 16) {
                AsyncImage(url: URL(string: item.image)) { image in
                    image
                        .resizable()
                        .scaledToFill()
                        .frame(width: geo.size.width, height: 340)
                        .clipped()
                        .scaleEffect(magnification)
                } placeholder: {
                    Rectangle()
                        .fill(.background)
                        .frame(height: 340)
                        .shimmering()
                } // AsyncImage
                .background(.regularMaterial)
                .overlay(alignment: .topTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Circle()
                            .fill(.regularMaterial)
                            .frame(width: 36, height: 36)
                            .overlay {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .imageScale(.small)
                                    .bold()
                                    .frame(width: 14, height: 14)
                                    .tint(.red)
                            }
                            .shadow(color: .black.opacity(0.06), radius: 6, y: 2)
                            .padding(18)
                    }
                    
                }
                .ignoresSafeArea(edges: .top)
                .zIndex(1)
                
                Group {
                    HStack(alignment: .firstTextBaseline) {
                        Text(item.title)
                            .font(.subtitle)
                        Spacer()
                        Text("$\(item.price)")
                            .font(.leadText)
                    } // HStack
                    
                    HStack {
                        Text(item.description)
                        Spacer()
                    }
                } // Group
                .padding(.horizontal, 16.0)
                
                Spacer()
                
                Button("Add to Cart", systemImage: "cart.badge.plus") {
                    // TODO: Add to cart
                    isShowingComingSoon.toggle()
                }
                .buttonStyle(.borderedProminent)
                .font(.headline)
            } // VStack
            .gesture(magnificationGesture)
        } // GeometryReader
        .alert("Coming Soon", isPresented: $isShowingComingSoon, actions: {
            Button("OK") {}
        }, message: {
            Text("This feature hasn't been implemented yet.")
        })
        .navigationTitle(item.title)
    }
}

#Preview {
    MenuDetail(item: .init(title: "Greek Salad", description: "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.", price: "10", image: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true", category: .mains))
}
