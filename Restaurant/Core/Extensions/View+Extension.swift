//
//  View+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/19/24.
//

import SwiftUI

extension View {
    func roundedBorder(_ width: Double, cornerRadius: Double = 8, color: Color = .primary) -> some View {
        overlay {
            RoundedRectangle.roundedRect(cornerRadius)
                .strokeBorder(lineWidth: width)
                .foregroundStyle(color)
        }
    }
}
