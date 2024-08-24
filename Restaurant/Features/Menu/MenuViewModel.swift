//
//  MenuViewModel.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/13/24.
//

import Combine
import CoreData
import UIKit

class MenuViewModel: BaseViewModel {
    @Published var searchQuery: String = ""
    @Published var searchState = LLTextFieldState.normal
    @Published var isShowingSearch = false
    @Published var menuList: MenuList?
    
    override func setupBindings() {
        super.setupBindings()
        fetchMenu()
            .receive(on: DispatchQueue.main)
            .assign(to: &$menuList, failure: &$networkingError)
    }
    
    @Inject(\.fileUtil) private var fileUtil
    @Inject(\.persistenceController) private var persistence
    
    var profileImage: UIImage? {
        get { fileUtil.read(image: "profile_image") }
        set {
            guard let newValue else {
                fileUtil.delete(image: "profile_image")
                return
            }
            fileUtil.write(newValue, name: "profile_image")
            self.objectWillChange.send()
        }
    }
    
    @MainActor
    func persistMenu(_ items: [MenuItem], context: NSManagedObjectContext) {
        persistence.clear()
        
        for item in items {
            let dish = Dish(context: context)
            dish.id = item.id
            dish.title = item.title
            dish.desc = item.description
            dish.price = item.price
            dish.image = item.image
            dish.category = item.category.rawValue
        }
        
        do {
            try context.save()
        } catch {
            print("Failed to save context: \(context)")
        }
    }
    
    func fetchMenu() -> AnyPublisher<MenuList, NetworkingError> {
        request(MenuList.self, from: MenuService.fetch)
    }
}

extension Container {
    var menuViewModel: Factory<MenuViewModel> {
        self { .init() }
            .unique
    }
}
