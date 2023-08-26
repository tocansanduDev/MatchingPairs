//
//  GameView.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import SwiftUI

struct Game {
    struct ContentView: View {
        @EnvironmentObject var viewModel: ViewModel
        
        var body: some View {
            LazyVGrid(columns: [GridItem(.adaptive(minimum: 100, maximum: 100))], spacing: 20) {
                ForEach($viewModel.cards) { $card in
                    CardView(card: $card, onDidFinishInteraction: viewModel.evaluate)
                        .disabled(viewModel.isEvaluating)
                }
            }
        }
    }
}

struct Game_ContentView_Previews: PreviewProvider {
    static var previews: some View {
        Game.ContentView()
            .environmentObject(Game.ViewModel.mock)
    }
}
