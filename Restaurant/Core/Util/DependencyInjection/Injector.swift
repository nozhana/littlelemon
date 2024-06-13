//
//  Injector.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/11/24.
//

import Foundation

@propertyWrapper
struct Inject<T> {
    let factory: Factory<T>
    var wrappedValue: T {
        get { self.factory() }
        set { self.factory.update(newValue) }
    }
    
    init(_ factory: Factory<T>) {
        self.factory = factory
    }
    
    init(_ factoryKeyPath: KeyPath<Container, Factory<T>>) {
        self.factory = Container.shared[keyPath: factoryKeyPath]
    }
    
    init<C>(_ containerKeyPath: KeyPath<Container, Factory<C>>, _ factoryKeyPath: KeyPath<C, Factory<T>>) where C: SharedContainer {
        self.factory = Container.shared[keyPath: containerKeyPath]()[keyPath: factoryKeyPath]
    }
    
    func update(_ value: T) {
        self.factory.update(value)
    }
    
    @discardableResult
    func clear() -> T? {
        self.factory.clear()
    }
}
