//
//  MatchingPairsApp.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 25.08.2023.
//

import SwiftUI

@main
struct MatchingPairsApp: App {
    
    var body: some Scene {
        WindowGroup {
            Root.ContentView()
                .environmentObject(Root.ViewModel(themesFetcher: FetchThemesService()))
                .environmentObject(OrientationInfo())
        }
    }
}
