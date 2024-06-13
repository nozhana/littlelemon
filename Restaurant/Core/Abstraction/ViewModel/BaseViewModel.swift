//
//  BaseViewModel.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/9/24.
//

import Foundation
import Combine

class BaseViewModel: ObservableObject {
    var disposeBag: Set<AnyCancellable> = []
    
    deinit {
        disposeBag.forEach { $0.cancel() }
        disposeBag.removeAll()
    }
}
