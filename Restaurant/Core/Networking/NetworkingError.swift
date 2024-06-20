//
//  NetworkingError.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/17/24.
//

import Foundation

enum NetworkingError: Error {
    case decodingError
    case middlewareError
    case badRequest, unauthorized, paymentRequired, forbidden, notFound, methodNotAllowed, notAcceptable
    case internalServerError, notImplemented, badGateway, serviceUnavailable, gatewayTimeout, bandwidthLimit, authenticationRequired
    case connectionLost, connectionOffline
    case unknown(status: Int, description: String)
}

extension NetworkingError {
    var statusCode: Int {
        switch self {
        case .decodingError:
            return 1
        case .middlewareError:
            return 2
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
        case .connectionLost:
            return -1005
        case .connectionOffline:
            return -1009
        case .unknown(let status, _):
            return status
        }
    }
    
    init(urlError: URLError) {
        switch urlError.errorCode {
        case 1:
            self = .decodingError
        case 2:
            self = .middlewareError
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
        case -1005:
            self = .connectionLost
        case -1009:
            self = .connectionOffline
        default:
            self = .unknown(status: urlError.errorCode, description: urlError.localizedDescription)
        }
    }
    
    init(nsError: NSError) {
        self = .unknown(status: nsError.code, description: nsError.localizedDescription)
    }
}

extension NetworkingError: LocalizedError {
    var errorDescription: String? {
        "\(self) (NetworkingError \(statusCode))"
    }
}

extension NetworkingError: CustomStringConvertible {
    var description: String {
        switch self {
        case .decodingError:
            return "Decoding Error"
        case .middlewareError:
            return "Middleware Error"
        case .badRequest:
            return "Bad Request"
        case .unauthorized:
            return "Unauthorized"
        case .paymentRequired:
            return "Payment Required"
        case .forbidden:
            return "Forbidden"
        case .notFound:
            return "Not Found"
        case .methodNotAllowed:
            return "Method Not Allowed"
        case .notAcceptable:
            return "Not Acceptable"
        case .internalServerError:
            return "Internal Server Error"
        case .notImplemented:
            return "Not Implemented"
        case .badGateway:
            return "Bad Gateway"
        case .serviceUnavailable:
            return "Service Unavailable"
        case .gatewayTimeout:
            return "Gateway Timeout"
        case .bandwidthLimit:
            return "Bandwidth Limit"
        case .authenticationRequired:
            return "Authentication Required"
        case .connectionLost:
            return "Connection Lost"
        case .connectionOffline:
            return "Connection Offline"
        case .unknown(_, let description):
            return "Unknown Error: \(description)"
        }
    }
}
