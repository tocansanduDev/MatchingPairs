//
//  RequestManager.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

protocol RequestManagerProtocol {
  func perform<T: Decodable>(_ request: RequestProtocol) async throws -> T
}

final class RequestManager: RequestManagerProtocol {
    let parser: DataParserProtocol
    let apiManager: APIManagerProtocol

    init(
      apiManager: APIManagerProtocol = APIManager(),
      parser: DataParserProtocol = DataParser()
    ) {
      self.apiManager = apiManager
      self.parser = parser
    }
    
    func perform<T>(_ request: RequestProtocol) async throws -> T where T : Decodable {
        let data = try await apiManager.perform(request)
        let decoded: T = try parser.parse(data: data)
        return decoded
    }
}
