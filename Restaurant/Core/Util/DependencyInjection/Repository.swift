//
//  Repository.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/11/24.
//

import Foundation

protocol Repository {
    func register<T>(_ value: T, forKey key: String?)
    func resolve<T>(_ type: T.Type, forKey key: String?) -> T?
    @discardableResult
    func clearValue<T>(_ type: T.Type, forKey key: String?) -> T?
}

class LocalRepository: Repository {
    private init() {}
    fileprivate static let shared = LocalRepository()
    
    private var values = [String: Any]()
    
    func register<T>(_ value: T, forKey key: String? = nil) {
        guard let key else {
            values["\(T.self)"] = value
            return
        }
        values["\(T.self).\(key)"] = value
    }
    
    func resolve<T>(_ type: T.Type, forKey key: String?) -> T? {
        guard let key else {
            return values["\(T.self)"] as? T
        }
        return values["\(T.self).\(key)"] as? T
    }
    
    func clearValue<T>(_ type: T.Type, forKey key: String?) -> T? {
        guard let key else {
            return values.removeValue(forKey: "\(T.self)") as? T
        }
        return values.removeValue(forKey: "\(T.self).\(key)") as? T
    }
}

extension Repository where Self == LocalRepository {
    static var local: Self { .shared }
}

protocol RepositoryProviding {
    var repository: Repository { get }
}

extension SharedContainer where Self: RepositoryProviding {
    func resolveSingleton<T>(_ type: T.Type, forKey key: String?) -> T? {
        repository.resolve(T.self, forKey: key)
    }
    
    func registerSingleton<T>(_ value: T, forKey key: String?) {
        repository.register(value, forKey: key)
    }
    
    func removeSingleton<T>(_ type: T.Type, forKey key: String?) -> T? {
        repository.clearValue(type, forKey: key)
    }
}
