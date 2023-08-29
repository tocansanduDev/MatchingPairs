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
        @Published private(set) var progress: Double = 0
        
        @UserDefault(key: "total_score", defaultValue: 0)
        var totalScore: Int
        
        private let theme: Theme
        private let difficultyLevel: DifficultyLevel
        private var flipCounter: Int = 0
        private var stopwatchTimer: Timer?
        
        var themeTitle: String {
            theme.title
        }
        
        var seconds: Double {
            Double(difficultyLevel.seconds)
        }
        
        var computedScore: Int {
            difficultyLevel.score + (flipCounter * 4)
        }
        
        init(theme: Theme, difficultyLevel: DifficultyLevel) {
            self.theme = theme
            self.difficultyLevel = difficultyLevel
        }
        
        func reset() {
            startTimer()
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
                if self.cards.isEmpty && self.completionState != .over {
                    self.congratulate()
                }
                self.isEvaluating = false
            }
        }
        
        private func handleTimerCompletion() {
            stopTimer()
            if cards.isEmpty  { return }
            setupCompletion(of: .over)
        }
        
        private func startTimer() {
            stopTimer()
            progress = 1
            var elapsedTime: Double = seconds
            let timeInterval: Double = 1
            stopwatchTimer = Timer.scheduledTimer(withTimeInterval: timeInterval, repeats: true, block: { [weak self] _ in
                guard let self else { return }
                if progress > 0 {
                    elapsedTime -= 1
                    withAnimation(.linear(duration: timeInterval)) {
                    self.progress = elapsedTime / self.seconds
                    }
                } else {
                    self.handleTimerCompletion()
                }
            })
        }
        
        private func stopTimer() {
            if let timer = stopwatchTimer {
                timer.invalidate()
                stopwatchTimer = nil
            }
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

