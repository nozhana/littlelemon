//
//  AnyNetworkingMiddleware.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

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
