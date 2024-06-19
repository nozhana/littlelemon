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
    
    @discardableResult
    func request<Response>(_ responseType: Response.Type, from service: Service, completion: ((Result<Response, NetworkingError>) -> Void)? = nil) -> AnyPublisher<Response, NetworkingError> where Response: Decodable {
        networker.request(responseType, from: service, completion: completion)
    }
    
    func request<Response>(_ responseType: Response.Type, from service: Service) async -> Result<Response, NetworkingError> where Response: Decodable {
        await networker.request(responseType, from: service)
    }
    
    deinit {
        disposeBag.forEach { $0.cancel() }
        disposeBag.removeAll()
    }
}
