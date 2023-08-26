//
//  Mock.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

extension Game.ViewModel {
    static var mock: Game.ViewModel {
        let theme: Theme = Theme(
            title: "Mock",
            symbols: ["🔴", "🔵", "🟠", "🟡", "🟢", "🟣"],
            cardSymbol: "🎈",
            cardColor: CardColor(blue: 0.549, green: 0.8667, red: 0.949)
        )
        return Game.ViewModel(theme: theme)
    }
}
