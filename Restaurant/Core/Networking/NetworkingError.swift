//
//  NetworkingError.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Foundation

enum NetworkingError: Error {
    case decodingError
    case badRequest, unauthorized, paymentRequired, forbidden, notFound, methodNotAllowed, notAcceptable
    case internalServerError, notImplemented, badGateway, serviceUnavailable, gatewayTimeout, bandwidthLimit, authenticationRequired
    case unknown(status: Int)
}

extension NetworkingError {
    var statusCode: Int {
        switch self {
        case .decodingError:
            return 1
        case .badRequest:
            return 400
        case .unauthorized:
            return 401
        case .paymentRequired:
            return 402
        case .forbidden:
            return 403
        case .notFound:
            return 404
        case .methodNotAllowed:
            return 405
        case .notAcceptable:
            return 406
        case .internalServerError:
            return 500
        case .notImplemented:
            return 501
        case .badGateway:
            return 502
        case .serviceUnavailable:
            return 503
        case .gatewayTimeout:
            return 504
        case .bandwidthLimit:
            return 505
        case .authenticationRequired:
            return 506
        case .unknown(let status):
            return status
        }
    }
    
    init(_ statusCode: Int) {
        switch statusCode {
        case 1:
            self = .decodingError
        case 400:
            self = .badRequest
        case 401:
            self = .unauthorized
        case 402:
            self = .paymentRequired
        case 403:
            self = .forbidden
        case 404:
            self = .notFound
        case 405:
            self = .methodNotAllowed
        case 406:
            self = .notAcceptable
        case 500:
            self = .internalServerError
        case 501:
            self = .notImplemented
        case 502:
            self = .badGateway
        case 503:
            self = .serviceUnavailable
        case 504:
            self = .gatewayTimeout
        case 505:
            self = .bandwidthLimit
        case 506:
            self = .authenticationRequired
        default:
            self = .unknown(status: statusCode)
        }
    }
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        "NetworkingError \(statusCode): \(self)"
    }
}
