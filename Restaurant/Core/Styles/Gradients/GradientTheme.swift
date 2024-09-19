//
//  GradientTheme.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/18/24.
//

import Foundation

protocol GradientTheme: Themable<PrimitiveGradient> {
    var background: PrimitiveGradient { get }
}
