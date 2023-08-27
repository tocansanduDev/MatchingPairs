//
//  Published + utils.swift
//  MatchingPairs
//
//  Created by Sandu Tocan on 26.08.2023.
//

import SwiftUI
import Combine

fileprivate var cancellables = [String : AnyCancellable] ()

public extension Published {
    init(wrappedValue defaultValue: Value, key: String) {
        let value = UserDefaults.standard.object(forKey: key) as? Value ?? defaultValue
        self.init(initialValue: value)
        cancellables[key] = projectedValue.sink { val in
            UserDefaults.standard.set(val, forKey: key)
        }
    }
}
