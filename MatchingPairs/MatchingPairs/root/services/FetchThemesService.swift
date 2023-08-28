//
//  FetchThemesService.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 28.08.2023.
//

import Foundation

struct FetchThemesService {
  private let requestManager: RequestManagerProtocol

  init(requestManager: RequestManagerProtocol = RequestManager()) {
    self.requestManager = requestManager
  }
}

// MARK: - ThemesFetcher
extension FetchThemesService: ThemesFetcher {
    func fetchThemes() async throws -> [Theme] {
        return try await requestManager.perform(ThemesRequest.getThemes)
    }
}

// MARK: - Mock
struct MockFetchThemesService: ThemesFetcher {
    func fetchThemes() async throws -> [Theme] {
        [Theme(title: "Mock1", symbols: [], cardSymbol: "", cardColor: CardColor(blue: 1, green: 1, red: 1)),
         Theme(title: "Mock2", symbols: [], cardSymbol: "", cardColor: CardColor(blue: 1, green: 1, red: 1))
        ]
    }
}
