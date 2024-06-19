//
//  NetworkingLoggingMiddleware.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

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
