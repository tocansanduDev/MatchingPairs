//
//  DispatchQueue + Utils.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import Foundation

extension DispatchQueue {
    public func after(seconds: Double, execute: @escaping () -> Void) {
        asyncAfter(deadline: .now() + seconds, execute: execute)
    }
}
