//
//  Symbol.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation
import SwiftUI

struct Card: Identifiable {
    let id: UUID
    let symbol: String
    let faceSymbol: String
    let color: Color
    var isFlipped: Bool
    
    init(symbol: String, faceSymbol: String, color: Color) {
        self.id = UUID()
        self.symbol = symbol
        self.faceSymbol = faceSymbol
        self.color = color
        self.isFlipped = false
    }
}

