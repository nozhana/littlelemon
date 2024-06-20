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
    
    private func preProcess(_ service: Service) -> Result<Service, NetworkingError> {
        var processed: Result<Service, NetworkingError> = .success(service)
    outer: 
        for middleware in middlewares {
            switch processed {
            case .success(let service):
                processed = middleware.request(service)
            case .failure:
                break outer
            }
        }
        return processed
    }
    
    private func postProcess<Response>(_ result: Result<Response, NetworkingError>) -> Result<Response, NetworkingError> {
        var processed = result
    outer:
        for middleware in middlewares {
            switch processed {
            case .success:
                processed = middleware.response(processed)
            case .failure:
                break outer
            }
        }
        return processed
    }
    
    @discardableResult
    func request<Response>(_ responseType: Response.Type, from service: Service, completion: ((Result<Response, NetworkingError>) -> Void)? = nil) -> AnyPublisher<Response, NetworkingError> where Response: Decodable {
        let subject = PassthroughSubject<Response, NetworkingError>()
        let requestResult = preProcess(service)
        if case .failure(let error) = requestResult {
            subject.send(completion: .failure(error))
            completion?(.failure(error))
            return subject.eraseToAnyPublisher()
        }
        
        processRequest(responseType, from: try! requestResult.get()) { result in
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
        let requestResult = preProcess(service)
        if case .failure(let error) = requestResult {
            return .failure(error)
        }
        
        let result = await processRequest(responseType, from: try! requestResult.get())
        return postProcess(result)
    }
}
