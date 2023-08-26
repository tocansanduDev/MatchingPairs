//
//  ResponseValidator.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

protocol ResponseValidatorProtocol {
    func validate(response: URLResponse?, data: Data?) throws -> Data
}

final class ResponseValidator: ResponseValidatorProtocol {
    func validate(response: URLResponse?, data: Data?) throws -> Data {
        guard let response = response as? HTTPURLResponse,
              response.statusCode == 200,
              let data = data
        else {
            throw NetworkError.invalidServerResponse
        }
        return data
    }
}
