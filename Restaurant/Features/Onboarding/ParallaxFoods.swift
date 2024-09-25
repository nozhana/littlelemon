//
//  ParallaxFoods.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/19/24.
//

import SwiftUI

enum ParallaxFoodItem: String, CaseIterable, Identifiable {
    case burgerPack = "BurgerPack"
    case cupcake = "Cupcake"
    case fish = "Fish"
    case friedChicken = "FriedChicken"
    case pie = "Pie"
    case pizza = "Pizza"
    case popcorn = "Popcorn"
    case salad = "Salad"
    case sandwich = "Sandwich"
    case smoothies = "Smoothies"
    case steak = "Steak"
    
    var id: String { rawValue }
}

struct ParallaxFoods: View {
    @ObservedObject private var motionManager = Inject[\.motionManager]
    
    @State private var foodItem = ParallaxFoodItem.burgerPack
    @State private var foodIterator = ParallaxFoodItem.allCases.makeLoopIterator()
    private let timer = Timer.publish(every: 1.5, on: .main, in: .common).autoconnect()
    
    private func showNextFood() {
        withAnimation(.easeInOut(duration: 0.5)) {
            guard let next = foodIterator.next() else { return }
            foodItem = next
        }
    }
    
    var body: some View {
        VStack {
            Image(foodItem.rawValue, bundle: .main)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(width: 240, height: 240)
                .shadow(color: .black.opacity(0.12), radius: 6, y: 4)
                .padding(16)
                .offset(x: motionManager.normalizedRoll * 30, y: motionManager.pitch * 30)
                .id(foodItem.rawValue)
                .transition(.backslide.combined(with: .scale).combined(with: .opacity))
        } // VStack
            .onAppear {
                motionManager.startMonitoringUpdates()
                _ = foodIterator.next()
            }
            .onReceive(timer) { _ in
                showNextFood()
            }
    }
}

#Preview {
    ParallaxFoods()
}
