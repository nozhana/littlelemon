//
//  ShapeStyle+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/18/24.
//

import SwiftUI

extension ShapeStyle {
    func wrapInContainer() -> some View {
        Rectangle().fill(self)
    }
}
