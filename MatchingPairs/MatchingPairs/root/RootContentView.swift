//
//  ContentView.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 25.08.2023.
//

import SwiftUI

struct Root {
    struct ContentView: View {
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            NavigationView {
                VStack {
                    ForEach(viewModel.themeNames, id: \.self) { name in
                        NavigationLink(name, destination: destinationView(themeName: name))
                    }
                }
                .navigationTitle("Matching Pairs")
                .task {
                    await viewModel.fetch()
                }
            }
        }
        
        private func destinationView(themeName: String) -> some View {
            Game.ContentView()
                .environmentObject(Game.ViewModel(theme: viewModel.theme(for: themeName)))
        }
    }
}

struct Root_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Root.ContentView()
            .environmentObject(Root.ViewModel(requestManager: RequestManager()))
    }
}
