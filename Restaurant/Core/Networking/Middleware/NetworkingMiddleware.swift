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
