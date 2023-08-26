//
//  ViewModel.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

extension Root {
    final class ViewModel: ObservableObject {
    
        @Published var themeNames: [String] = []
        @Published var errorMessage: String? = nil
        @Published var isLoading: Bool = false
        
        private var themes: [Theme] = []
        
        private let requestManager: RequestManagerProtocol
        
        init(requestManager: RequestManagerProtocol) {
            self.requestManager = requestManager
        }
        
        @MainActor func fetch() async {
            errorMessage = nil
            isLoading = true
            do {
                themes = try await requestManager.perform(ThemesRequest.getThemes)
                themeNames = themes.map { $0.title }
            } catch {
                errorMessage = error.localizedDescription
            }
        }
        
        func fetchTask() {
            Task {
                await fetch()
            }
        }
        
        func theme(for name: String) -> Theme {
            return themes.first { $0.title == name }!
        }
        
    }

}
