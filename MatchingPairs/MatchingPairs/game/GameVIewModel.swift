//
//  GameVIewModel.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation
import SwiftUI
import Combine

extension Game {
    
    final class ViewModel: ObservableObject {
        
        @Published var cards: [Card] = []
        @Published var isEvaluating: Bool = false
        @Published var completionState: GameCompletion? = nil
        @Published var score: Int = 0
        
        @UserDefault(key: "total_score", defaultValue: 0)
        var totalScore: Int
        
        let onRestartTimer = PassthroughSubject<Void, Never>()
        private let theme: Theme
        private let difficultyLevel: DifficultyLevel
        private var flipCounter: Int = 0
        
        var themeTitle: String {
            theme.title
        }
        
        var seconds: Int {
            difficultyLevel.seconds
        }
        
        var computedScore: Int {
            difficultyLevel.score + (flipCounter * 4)
        }
        
        init(theme: Theme, difficultyLevel: DifficultyLevel) {
            self.theme = theme
            self.difficultyLevel = difficultyLevel
            reset()
        }
        
        func reset() {
            onRestartTimer.send()
            score = 0
            completionState = nil
            var dublicatedSymbols: [String] = []
            let symbols = theme.symbols.prefix(difficultyLevel.cards)
            for _ in 0...1 {
                dublicatedSymbols.append(contentsOf: symbols)
            }
            self.cards = dublicatedSymbols.map {
                Card(symbol: theme.cardSymbol, faceSymbol: $0, color: theme.color)
            }.shuffled()
            flipCounter = cards.count * 2
        }
        
        func evaluate() {
            if flipCounter > 0 {
                flipCounter -= 1
            }
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
        
        func onGameOver() {
            setupCompletion(of: .over)
        }
        
        private func onSuccess() {
            self.score += computedScore
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
            setupCompletion(of: .won)
            totalScore += score
        }
        
        private func setupCompletion(of state: GameCompletion) {
            withAnimation(.spring(response: 0.4, dampingFraction: 0.9)) {
                self.completionState = state
            }
        }
        
    }
    
}

