//
//  Inject.swift
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
        set { self.update(newValue) }
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
    
    fileprivate func update(_ value: T) {
        self.factory.update(value)
    }
    
    @discardableResult
    func clear() -> T? {
        self.factory.clear()
    }
}

extension Inject where T == Any {
    static subscript<V>(_ factoryKeyPath: KeyPath<Container, Factory<V>>) -> V {
        get { Inject<V>(factoryKeyPath).wrappedValue }
        set { Inject<V>(factoryKeyPath).update(newValue) }
    }
    
    static subscript<C, V>(_ containerKeyPath: KeyPath<Container, Factory<C>>, _ factoryKeyPath: KeyPath<C, Factory<V>>) -> V where C: SharedContainer {
        get { Inject<V>(containerKeyPath, factoryKeyPath).wrappedValue }
        set { Inject<V>(containerKeyPath, factoryKeyPath).update(newValue) }
    }
}
