//
//  GameVIewModel.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation
import SwiftUI

extension Game {
    final class ViewModel: ObservableObject {
        
        @Published var cards: [Card] = []
        @Published var isEvaluating: Bool = false
        
        private let theme: Theme
        
        init(theme: Theme) {
            self.theme = theme
            setup()
        }
        
        func setup() {
            var dublicatedSymbols: [String] = []
            for _ in 0...1 {
                dublicatedSymbols.append(contentsOf: theme.symbols)
            }
            self.cards = dublicatedSymbols.map {
                Card(symbol: theme.cardSymbol, faceSymbol: $0, color: theme.color)
            }.shuffled()
        }
        
        func evaluate() {
            let flippedCards = cards.filter({ $0.isFlipped })
            guard flippedCards.count == 2 else { return }
            isEvaluating = true
            DispatchQueue.main.after(seconds: 0.7) {
                if flippedCards[0].faceSymbol == flippedCards[1].faceSymbol {
                    withAnimation(.easeInOut(duration: 0.2)) {
                        self.cards.removeAll { $0.isFlipped }
                    }
                } else {
                    withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) {
                        self.cards.modifyForEach { $1.isFlipped = false }
                    }
                }
                self.isEvaluating = false
            }
        }
    }
    
}
