//
//  DifficultyLevel.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 27.08.2023.
//

import Foundation

enum DifficultyLevel: CaseIterable {
    case easy
    case normal
    case hard
    
    var seconds: Int {
        switch self {
        case .easy: return 40
        case .normal: return 30
        case .hard: return 20
        }
    }
    
    var cards: Int {
        switch self {
        case .easy: return 2
        case .normal: return 4
        case .hard: return 8
        }
    }
    
    var description: String {
        switch self {
        case .easy: return "Easy"
        case .normal: return "Normal"
        case .hard: return "Hard"
        }
    }
    
    var score: Int {
        cards * seconds
    }
}
