//
//  BaseTabItem.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import SwiftUI

protocol BaseTabItem: Hashable, CaseIterable {
    associatedtype TabLabel: View
    @ViewBuilder
    var label: TabLabel { get }
}
