//
//  SnackbarViewModifier.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import SwiftUI

fileprivate
struct SnackbarViewModifier: ViewModifier {
    @Binding var isPresented: Bool
    let configuration: SnackbarConfiguration
    
    @Environment(\.snackbarStyle) private var style
    
    func body(content: Content) -> some View {
        ZStack {
            content
            if isPresented {
                style.makeBody(configuration)
                    .onTapGesture {
                        DispatchQueue.main.async {
                            withAnimation {
                                isPresented = false
                            }
                        }
                    } // onTapGesture
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                isPresented = false
                            }
                        } // asyncAfter
                    } // onAppear
            } // if
        } // ZStack
    } // body
}

extension View {
    func snackbar(_ isPresented: Binding<Bool>, configuration: SnackbarConfiguration) -> some View {
        modifier(SnackbarViewModifier(isPresented: isPresented, configuration: configuration))
    }
}
