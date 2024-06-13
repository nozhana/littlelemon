//
//  DefaultsContainer.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/11/24.
//

import Foundation

struct DefaultsRepository: Repository {
    let storage: UserDefaults
    
    func resolve<T>(_ type: T.Type, forKey key: String?) -> T? {
        guard let key else { return nil }
        return storage.value(forKey: key) as? T
    }
    
    func register<T>(_ value: T, forKey key: String?) {
        guard let key else { return }
        storage.setValue(value, forKey: key)
    }
    
    func clearValue<T>(_ type: T.Type, forKey key: String?) -> T? {
        guard let key,
              let value = resolve(type, forKey: key) else { return nil }
        storage.removeObject(forKey: key)
        return value
    }
}

struct DefaultsContainer: SharedContainer, RepositoryProviding {
    let repository: Repository
}

extension Container {
    private var userDefaultsRepository: Factory<DefaultsRepository> {
        self { DefaultsRepository(storage: .shared) }
            .singleton
    }
    
    var userDefaults: Factory<DefaultsContainer> {
        self { DefaultsContainer(repository: userDefaultsRepository()) }
            .singleton
    }
}
