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
        ZStack(alignment: .bottom) {
            content
            if isPresented {
                style.makeBody(configuration)
                    .onTapGesture {
                        withAnimation {
                            isPresented = false
                        }
                    } // onTapGesture
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            withAnimation {
                                isPresented = false
                            }
                        } // asyncAfter
                    } // onAppear
                    .transition(.move(edge: .bottom).combined(with: .opacity))
                    .animation(.easeOut(duration: 0.2))
            } // if
        } // ZStack
    } // body
}

extension View {
    func snackbar(_ isPresented: Binding<Bool>, configuration: SnackbarConfiguration) -> some View {
        modifier(SnackbarViewModifier(isPresented: isPresented, configuration: configuration))
    }
}
