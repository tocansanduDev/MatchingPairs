//
//  MatchingPairsApp.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 25.08.2023.
//

import SwiftUI

@main
struct MatchingPairsApp: App {
    private let requestManager: RequestManagerProtocol = RequestManager()
    
    var body: some Scene {
        WindowGroup {
            Root.ContentView()
                .environmentObject(Root.ViewModel(requestManager: requestManager))
        }
    }
}
