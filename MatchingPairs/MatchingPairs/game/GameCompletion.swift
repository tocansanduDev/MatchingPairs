//
//  GameCompletion.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 27.08.2023.
//

import Foundation

extension Game {
    
    enum GameCompletion {
        case over
        case won
        
        var message: String {
            switch self {
            case .won: return "You won!"
            case .over: return "Game over!"
            }
        }
    }

    
}
