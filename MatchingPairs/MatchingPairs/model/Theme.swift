//
//  Theme.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation
import SwiftUI

struct Theme : Decodable {
    let title: String
    let symbols: [String]
    let cardSymbol: String
    let cardColor: CardColor
    
    var color: Color {
        Color(red: cardColor.red, green: cardColor.green, blue: cardColor.blue)
    }
    
    enum CodingKeys: String, CodingKey {
        case title
        case symbols
        case cardSymbol = "card_symbol"
        case cardColor = "card_color"
    }
}

struct CardColor: Decodable {
    let blue: Double
    let green: Double
    let red: Double
}
