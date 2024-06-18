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
}

extension Service {
    var method: RequestMethod { .get }
    var headers: [String: String] { [:] }
    
    var urlRequest: URLRequest {
        URLRequest(url: URL(string: baseURL)!.appending(path: path), timeoutInterval: 30)
    }
}
