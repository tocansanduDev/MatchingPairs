//
//  APIManger.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

protocol APIManagerProtocol {
    func perform(_ request: RequestProtocol) async throws -> Data
}

class APIManager: APIManagerProtocol {
    private let urlSession: URLSession
    private let responseValidator: ResponseValidatorProtocol
    
    init(urlSession: URLSession = URLSession.shared,
         responseValidator: ResponseValidatorProtocol = ResponseValidator()) {
        self.urlSession = urlSession
        self.responseValidator = responseValidator
    }
    
    func perform(_ request: RequestProtocol) async throws -> Data {
        let (data, response) = try await urlSession.data(for: request.createURLRequest(authToken: APIConstants.token))
        return try responseValidator.validate(response: response, data: data)
    }
}


