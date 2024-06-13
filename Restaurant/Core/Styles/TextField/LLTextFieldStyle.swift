//
//  LLTextFieldStyle.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import SwiftUI

struct LLTextFieldStyle: TextFieldStyle {
    @Binding var state: LLTextFieldState
    @Binding var content: String
    let placeholder: String
    let icon: String?
    let errorMessage: String?
    let fixedHeight: Bool
    
    @FocusState private var focused: Bool
    
    init(state: Binding<LLTextFieldState>, content: Binding<String>, placeholder: String, icon: String? = nil, errorMessage: String? = nil, fixedHeight: Bool = false) {
        self._state = state
        self._content = content
        self.placeholder = placeholder
        self.icon = icon
        self.errorMessage = errorMessage
        self.fixedHeight = fixedHeight
    }
    
    func _body(configuration: TextField<Self._Label>) -> some View {
        VStack(alignment: .leading, spacing: 2) {
            ZStack {
                RoundedRectangle.roundedRect8
                    .fill(.background)
                
                RoundedRectangle.roundedRect8
                    .strokeBorder(lineWidth: 2)
                    .foregroundStyle(state == .active ? Color.primary.opacity(0.5) : state == .error ? .red.opacity(0.5) : .primary.opacity(0.14))
                
                HStack(spacing: 12) {
                    if let icon {
                        Image(systemName: icon)
                    }
                    
                    configuration
                        .focused($focused)
                        .foregroundStyle(state == .error ? .red : .primary)
                    
                    if !content.isEmpty {
                        Button {
                            withAnimation {
                                content = ""
                            }
                        } label: {
                            Image(systemName: "xmark")
                                .foregroundStyle(Color.primary)
                        }
                        .transition(.scale.combined(with: .opacity))
                    }
                } // HStack
                .padding(.horizontal, 8)
                
                if state == .disabled {
                    RoundedRectangle.roundedRect8
                        .fill(.gray.opacity(0.5))
                }
            } // ZStack
            .frame(height: 45)
            
            if let errorMessage {
                Text(errorMessage)
                    .font(.caption)
                    .foregroundStyle(state == .error ? .red : .primary.opacity(0.5))
                    .transition(.move(edge: .top).combined(with: .opacity))
            } else if !content.isEmpty {
                Text(placeholder)
                    .font(.caption)
                    .foregroundStyle(.primary.opacity(0.5))
                    .transition(.move(edge: .top).combined(with: .opacity))
            }
        } // VStack
        .frame(height: fixedHeight ? 45 : nil, alignment: .top)
        .onChange(of: focused) { flag in
            guard state != .error else { return }
            state = flag ? .active : .normal
        }
        .disabled(state == .disabled)
    } // _body
}

extension TextFieldStyle where Self == LLTextFieldStyle {
    static func llTextFieldStyle(state: Binding<LLTextFieldState>, content: Binding<String>, placeholder: String, icon: String? = nil, errorMessage: String? = nil, fixedHeight: Bool = false) -> Self {
        .init(state: state, content: content, placeholder: placeholder, icon: icon, errorMessage: errorMessage, fixedHeight: fixedHeight)
    }
}
