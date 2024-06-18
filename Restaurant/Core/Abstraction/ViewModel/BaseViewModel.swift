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
    
    @Inject(\.networker) private var networker
    
    func request<Response>(_ responseType: Response.Type, from service: Service) -> AnyPublisher<Response, NetworkingError> where Response: Decodable {
        networker.request(responseType, from: service)
    }
    
    deinit {
        disposeBag.forEach { $0.cancel() }
        disposeBag.removeAll()
    }
}
