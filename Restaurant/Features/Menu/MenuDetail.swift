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
                        .scaleEffect(magnification)
                } placeholder: {
                    Rectangle()
                        .fill(.background)
                        .shimmering()
                } // AsyncImage
                .frame(width: geo.size.width, height: 340)
                .background(.regularMaterial)
                .overlay(alignment: .topTrailing) {
                    Button {
                        dismiss()
                    } label: {
                        Circle()
                            .fill(.regularMaterial)
                            .frame(width: 44, height: 44)
                            .overlay {
                                Image(systemName: "xmark")
                                    .resizable()
                                    .scaledToFit()
                                    .imageScale(.small)
                                    .bold()
                                    .frame(width: 18, height: 18)
                                    .tint(.red)
                            }
                            .shadow(color: .black.opacity(0.12), radius: 8, y: 4)
                            .padding(12)
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
                }
                .buttonStyle(.borderedProminent)
                .font(.sectionTitle)
            } // VStack
            .gesture(magnificationGesture)
        } // GeometryReader
        .navigationTitle(item.title)
    }
}

#Preview {
    MenuDetail(item: .init(title: "Greek Salad", description: "The famous greek salad of crispy lettuce, peppers, olives, our Chicago.", price: "10", image: "https://github.com/Meta-Mobile-Developer-PC/Working-With-Data-API/blob/main/images/greekSalad.jpg?raw=true"))
}
