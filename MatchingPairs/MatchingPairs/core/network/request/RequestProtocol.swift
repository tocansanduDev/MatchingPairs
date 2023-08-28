//
//  RequestProtocol.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

protocol RequestProtocol {
    var path: String { get }
    var requestType: RequestType { get }
}

// MARK: - Default RequestProtocol
extension RequestProtocol {
    
    var host: String {
        APIConstants.host
    }
    
    func createURLRequest(authToken: String) throws -> URLRequest {
        let scheme = "https://"
        let host = host
        let path = path + "&token=\(authToken)"
        guard let url = URL(string: scheme + host + path) else { throw  NetworkError.invalidURL }
        return URLRequest(url: url)
    }
    
}

enum RequestType: String {
  case GET
}
