//
//  CombineNetworking.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Combine
import Foundation

protocol CombineNetworking {
    func request<Response>(_ responseType: Response.Type, from service: Service) -> AnyPublisher<Response, NetworkingError> where Response: Decodable
}
