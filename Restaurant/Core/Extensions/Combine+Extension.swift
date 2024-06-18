//
//  Combine+Extension.swift
//  Restaurant
//
//  Created by Nozhan Amiri on 6/18/24.
//

import Combine
import Foundation

extension Publisher {
    var mappedResult: AnyPublisher<Result<Output, Failure>, Never> {
        map {
            .success($0)
        }
        .catch {
            Just(.failure($0))
        }
        .eraseToAnyPublisher()
    }
    
    func sinkToResult(receiveResult resultCompletion: @escaping (Result<Output, Failure>) -> Void) -> AnyCancellable {
        mappedResult.sink(receiveValue: resultCompletion)
    }
    
    func assign(to published: inout Published<Self.Output?>.Publisher, failure: inout Published<Self.Failure?>.Publisher) {
        mappedResult
            .compactMap {
                switch $0 {
                case .success(let data):
                    return data
                default: return nil
                }
            }
            .assign(to: &published)
        
        mappedResult
            .compactMap {
                switch $0 {
                case .failure(let error):
                    return error
                default: return nil
                }
            }
            .assign(to: &failure)
    }
}
