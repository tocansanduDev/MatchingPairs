//
//  ViewModel.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation
import SwiftUI

extension Root {
    final class ViewModel: ObservableObject {
        
        @Published var difficyltyLevel: DifficultyLevel = .easy
        @Published var themeNames: [String] = []
        @Published var errorMessage: String? = nil
        @Published var isLoading: Bool = false
        @Published var totalScore: Int = 0

        private var themes: [Theme] = []
        
        private let requestManager: RequestManagerProtocol
        
        init(requestManager: RequestManagerProtocol) {
            self.requestManager = requestManager
            self.fetch()
        }
        
        func fetch() {
            errorMessage = nil
            isLoading = true
            Task { @MainActor in
                do {
                    themes = try await requestManager.perform(ThemesRequest.getThemes)
                    themeNames = themes.map { $0.title }
                    isLoading = false
                } catch {
                    isLoading = false
                    errorMessage = error.localizedDescription
                }
            }
        }
        
        func fetchScore() {
            @UserDefault(key: "total_score", defaultValue: 0)
            var score: Int
            totalScore = score
        }
        
        func theme(for name: String) -> Theme {
            return themes.first { $0.title == name }!
        }
        
    }

}
