//
//  Themable.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/18/24.
//

import Foundation

protocol Themable<PrimitiveValue> {
    associatedtype PrimitiveValue: Primitive
}

extension Themable {
    subscript(_ keyPath: KeyPath<Self, PrimitiveValue>) -> PrimitiveValue.ValueType {
        self[keyPath: keyPath].value
    }
}
