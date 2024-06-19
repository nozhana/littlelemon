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
                completion(.failure(NetworkingError(error.errorCode)))
                return
            } else if let error {
                print("NetworkingError unknown: 3 - \(error.localizedDescription)")
                completion(.failure(.unknown(status: 3))) // FIXME: UnknownError
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
                return .failure(NetworkingError(error.errorCode))
            }
            print("NetworkingError unknown: 3 - \(error.localizedDescription)")
            return .failure(.unknown(status: 3)) // FIXME: UnknownError
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
