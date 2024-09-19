//
//  Primitive.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/18/24.
//

import Foundation

protocol Primitive {
    associatedtype ValueType
    var value: ValueType { get }
}
