//
//  NetworkingMiddleware.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

protocol NetworkingMiddleware {
    func request(_ service: Service) -> Service?
    func response<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError>
}

extension NetworkingMiddleware {
    func request(_ service: Service) -> Service? {
        service
    }
    
    func response<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError> {
        result
    }
}

struct AnyNetworkingMiddleware: NetworkingMiddleware {
    private let middleware: any NetworkingMiddleware
    
    init(_ middleware: any NetworkingMiddleware) {
        self.middleware = middleware
    }
    
    func request(_ service: Service) -> Service? {
        middleware.request(service)
    }
    
    func response<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError> {
        middleware.response(result)
    }
}

extension NetworkingMiddleware {
    func eraseToAnyNetworkingMiddleware() -> AnyNetworkingMiddleware {
        .init(self)
    }
}

struct NetworkingLoggingMiddleware: NetworkingMiddleware {
    func request(_ service: Service) -> Service? {
        print("Request BaseURL: \(service.baseURL)")
        print("Request path: \(service.path)")
        print("Request headers: \(service.headers)")
        print("Request method: \(service.method)")
        print("Request body: \(String(describing: service.urlRequest.httpBody))") // FIXME: service.body
        return service
    }
    
    func response<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError> {
        switch result {
        case .success(let response):
            print("Response.success: \(response)")
        case .failure(let error):
            print("Response.failure: \(error)")
        }
        return result
    }
}
