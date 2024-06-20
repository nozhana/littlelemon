//
//  URLSessionCombineNetworker.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Combine
import Foundation

struct URLSessionCombineNetworker: CombineNetworking {
    var middlewares: [AnyNetworkingMiddleware] = []
    
    func processRequest<Response>(_ responseType: Response.Type, from service: Service, completion: @escaping (Result<Response, NetworkingError>) -> Void) where Response : Decodable {
        let task = URLSession.shared.dataTask(with: service.urlRequest) { data, response, error in
            if let error = error as? URLError {
                completion(.failure(NetworkingError(urlError: error)))
                return
            } else if let error = error as? NSError {
                completion(.failure(NetworkingError(nsError: error)))
            }
            
            guard let data,
                  let decoded = try? JSONDecoder().decode(responseType, from: data) else {
                completion(.failure(.decodingError))
                return
            }
            
            completion(.success(decoded))
        }
        task.resume()
    }
    
    func processRequest<Response>(_ responseType: Response.Type, from service: Service) async -> Result<Response, NetworkingError> where Response : Decodable {
        var data: Data
        do {
            (data, _) = try await URLSession.shared.data(for: service.urlRequest)
        } catch {
            if let error = error as? URLError {
                return .failure(NetworkingError(urlError: error))
            }
            return .failure(NetworkingError(nsError: error as NSError))
        }
        
        guard let decoded = try? JSONDecoder().decode(responseType, from: data) else {
            return .failure(.decodingError)
        }
        
        return .success(decoded)
    }
}

extension Container {
    var networker: Factory<CombineNetworking> {
        self {
            var networker = URLSessionCombineNetworker()
            networker.registerMiddleware(NetworkingLoggingMiddleware())
            return networker
        }
    }
}
