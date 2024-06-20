//
//  NetworkingMiddleware.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/19/24.
//

import Foundation

protocol NetworkingMiddleware {
    func request(_ service: Service) -> Result<Service, NetworkingError>
    func response<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError>
}

extension NetworkingMiddleware {
    func request(_ service: Service) -> Result<Service, NetworkingError> {
        .success(service)
    }
    
    func response<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError> {
        result
    }
}
