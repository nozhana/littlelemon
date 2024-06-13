//
//  Factory.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/11/24.
//

import Foundation

enum FactoryType {
    case singleton, unique
}

struct Factory<ValueType> {
    private let container: SharedContainer
    fileprivate let key: String?
    fileprivate let type: FactoryType
    fileprivate let factory: () -> ValueType
    
    init(_ container: SharedContainer, key: String? = nil, factory: @escaping () -> ValueType) {
        self.container = container
        self.key = key
        self.type = .unique
        self.factory = factory
    }
    
    fileprivate init(_ container: SharedContainer, key: String? = nil, type: FactoryType, factory: @escaping () -> ValueType) {
        self.container = container
        self.key = key
        self.type = type
        self.factory = factory
    }
    
    func callAsFunction() -> ValueType {
        container.resolve(self)
    }
    
    func update(_ value: ValueType) {
        container.update(self, value)
    }
    
    @discardableResult
    func clear() -> ValueType? {
        container.clear(self)
    }
}

extension Factory {
    var singleton: Factory<ValueType> {
        Factory(container, key: key, type: .singleton, factory: factory)
    }
}

protocol SharedContainer {
    func resolveSingleton<T>(_ type: T.Type, forKey key: String?) -> T?
    func registerSingleton<T>(_ value: T, forKey key: String?)
    @discardableResult
    func removeSingleton<T>(_ type: T.Type, forKey key: String?) -> T?
    
    func resolve<T>(_ factory: Factory<T>) -> T
    func update<T>(_ factory: Factory<T>, _ value: T)
    @discardableResult
    func clear<T>(_ factory: Factory<T>) -> T?
    func callAsFunction<T>(key: String?, _ factory: @escaping () -> T) -> Factory<T>
}

extension SharedContainer {
    func resolve<T>(_ factory: Factory<T>) -> T {
        switch factory.type {
        case .singleton:
            if let singleton = resolveSingleton(T.self, forKey: factory.key) {
                return singleton
            } else {
                let singleton = factory.factory()
                registerSingleton(singleton, forKey: factory.key)
                return singleton
            }
        case .unique:
            return factory.factory()
        }
    }
    
    func update<T>(_ factory: Factory<T>, _ value: T) {
        switch factory.type {
        case .unique: return
        case .singleton:
            registerSingleton(value, forKey: factory.key)
        }
    }
    
    func clear<T>(_ factory: Factory<T>) -> T? {
        switch factory.type {
        case .unique: return nil
        case .singleton:
            return removeSingleton(T.self, forKey: factory.key)
        }
    }
    
    func callAsFunction<T>(key: String? = nil, _ factory: @escaping () -> T) -> Factory<T> {
        Factory(self, key: key, factory: factory)
    }
}

struct Container: SharedContainer, RepositoryProviding {
    private init() {}
    static let shared = Container()
    
    var repository: Repository { .local }
}
