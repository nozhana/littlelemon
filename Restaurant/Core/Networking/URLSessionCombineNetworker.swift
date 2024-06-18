//
//  URLSessionCombineNetworker.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Combine
import Foundation

struct URLSessionCombineNetworker: CombineNetworking {
    func request<Response>(_ responseType: Response.Type, from service: Service) -> AnyPublisher<Response, NetworkingError> where Response : Decodable {
        // FIXME: Debug
        print("Requesting: \(service)")
        print("Base URL: \(service.baseURL)")
        print("Path: \(service.path)")
        print("URLRequest: \(service.urlRequest)")
        print("Method: \(service.method)")
        
        let subject = PassthroughSubject<Response, NetworkingError>()
        
        let task = URLSession.shared.dataTask(with: service.urlRequest) { data, response, error in
            if let error = error as? URLError {
                print("NetworkingError \(error)")
                subject.send(completion: .failure(NetworkingError(error.errorCode)))
                return
            }
            
            guard let data,
                  let decoded = try? JSONDecoder().decode(Response.self, from: data) else {
                // FIXME: Debug
                print("DecodingError")
                subject.send(completion: .failure(NetworkingError.decodingError))
                return
            }
            
            // FIXME: Debug
            print("Decoded \(decoded)")
            subject.send(decoded)
        }
        
        task.resume()
        return subject.eraseToAnyPublisher()
    }
}

extension Container {
    var networker: Factory<CombineNetworking> {
        self { URLSessionCombineNetworker() }
    }
}
