//
//  LoopIterator.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 9/20/24.
//

import Foundation

struct LoopIterator<Base: Collection>: IteratorProtocol {
    private let base: Base
    private var index: Base.Index
    
    init(_ base: Base) {
        self.base = base
        self.index = base.startIndex
    }
    
    mutating func next() -> Base.Element? {
        guard !base.isEmpty else { return nil }
        
        let result = base[index]
        base.formIndex(after: &index)
        
        if index == base.endIndex {
            index = base.startIndex
        }
        
        return result
    }
}

extension Collection {
    func makeLoopIterator() -> LoopIterator<Self> {
        .init(self)
    }
}
