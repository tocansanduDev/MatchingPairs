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
        @Published var score: Int = 0
        @Published var congratulationMessage: String? = nil
        
        private let theme: Theme
        
        var themeTitle: String {
            theme.title
        }
        
        init(theme: Theme) {
            self.theme = theme
            reset()
        }
        
        func reset() {
            score = 0
            congratulationMessage = nil
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
            DispatchQueue.main.after(seconds: 0.5) {
                if flippedCards[0].faceSymbol == flippedCards[1].faceSymbol {
                    self.onSuccess()
                } else {
                    self.onFailure()
                }
                if self.cards.isEmpty {
                    self.congratulate()
                }
                self.isEvaluating = false
            }
        }
        
        private func onSuccess() {
            self.score += 2
            withAnimation(.easeInOut(duration: 0.2)) {
                self.cards.removeAll { $0.isFlipped }
            }
        }
        
        private func onFailure() {
            withAnimation(.spring(response: 0.2, dampingFraction: 0.6)) {
                self.cards.modifyForEach { $1.isFlipped = false }
            }
        }
        
        private func congratulate() {
            let generator = UINotificationFeedbackGenerator()
            generator.notificationOccurred(.success)
            withAnimation(.spring(response: 0.4, dampingFraction: 0.9)) {
                self.congratulationMessage = "You won!"
            }
        }
        
    }
    
}
