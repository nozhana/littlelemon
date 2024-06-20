//
//  CombineNetworking.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Combine
import Foundation

protocol CombineNetworking {
    var middlewares: [AnyNetworkingMiddleware] { get set }
    func processRequest<Response>(_ responseType: Response.Type, from service: Service, completion: @escaping (Result<Response, NetworkingError>) -> Void) where Response: Decodable
    func processRequest<Response>(_ responseType: Response.Type, from service: Service) async -> Result<Response, NetworkingError> where Response: Decodable
}

extension CombineNetworking {
    mutating func registerMiddleware<M>(_ middleware: M) where M: NetworkingMiddleware {
        middlewares.append(middleware.eraseToAnyNetworkingMiddleware())
    }
    
    func preProcess(_ service: Service) -> Service? {
        var processed: Service? = service
        processed = middlewares.reduce(into: processed) { partialResult, middleware in
            guard let request = partialResult else {
                return
            }
            partialResult = middleware.request(request)
        }
        return processed
    }
    
    func postProcess<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError> {
        var processed = result
        processed = middlewares.reduce(into: processed) { partialResult, middleware in
            partialResult = middleware.response(partialResult)
        }
        return processed
    }
    
    @discardableResult
    func request<Response>(_ responseType: Response.Type, from service: Service, completion: ((Result<Response, NetworkingError>) -> Void)? = nil) -> AnyPublisher<Response, NetworkingError> where Response: Decodable {
        let subject = PassthroughSubject<Response, NetworkingError>()
        guard let request = preProcess(service) else {
            subject.send(completion: .failure(.middlewareError))
            completion?(.failure(.middlewareError))
            return subject.eraseToAnyPublisher()
        }
        processRequest(responseType, from: request) { result in
            let response = postProcess(result)
            switch response {
            case .success(let decoded):
                subject.send(decoded)
            case .failure(let error):
                subject.send(completion: .failure(error))
            }
            completion?(response)
        }
        return subject.eraseToAnyPublisher()
    }
    
    func request<Response>(_ responseType: Response.Type, from service: Service) async -> Result<Response, NetworkingError> where Response: Decodable {
        guard let request = preProcess(service) else {
            return .failure(.middlewareError)
        }
        let result = await processRequest(responseType, from: service)
        return postProcess(result)
    }
}
