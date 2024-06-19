//
//  Service.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Foundation

protocol Service {
    var baseURL: String { get }
    var path: String { get }
    var method: RequestMethod { get }
    var headers: [String: String] { get }
    // TODO: Query params, body, etc.
}

extension Service {
    var method: RequestMethod { .get }
    var headers: [String: String] { [:] }
    
    var urlRequest: URLRequest {
        var request = URLRequest(url: URL(string: baseURL)!.appending(path: path), timeoutInterval: 30)
        request.allHTTPHeaderFields?.merge(headers, uniquingKeysWith: { _, new in
            new
        })
        request.httpMethod = method.rawValue.uppercased()
        return request
    }
}

struct CustomService: Service {
    var baseURL: String
    var path: String
    var method: RequestMethod
    var headers: [String : String]
    
    init(baseURL: String, path: String, method: RequestMethod = .get, headers: [String : String] = [:]) {
        self.baseURL = baseURL
        self.path = path
        self.method = method
        self.headers = headers
    }
    
    init(_ service: Service) {
        self.baseURL = service.baseURL
        self.path = service.path
        self.method = service.method
        self.headers = service.headers
    }
}
